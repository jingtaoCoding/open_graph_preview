defmodule LunaAppWeb.OpenGraphController do
  use LunaAppWeb, :controller

  alias LunaApp.OpenGraphs
  alias LunaApp.OpenGraphs.OpenGraph

  def index(conn, _params) do
    changeset = OpenGraphs.change_open_graph(%OpenGraph{})
    render(conn, "new.html", changeset: changeset, open_graph: nil)
  end

  def create(conn, %{"open_graph" => %{"url" => url} = params}) do
    sanitized = sanitize_url(url)

    case OpenGraphs.upsert_open_graph(%{url: sanitized}) do
      {:ok, %OpenGraph{status: "pending"} = open_graph} ->
        OpenGraphs.async_fetch(open_graph)
        render_create(conn, %{open_graph: open_graph})

      {:ok, open_graph} ->
        render_create(conn, %{open_graph: open_graph})
    end
  end

  defp render_create(conn, %{open_graph: open_graph}) do
    conn
    |> assign(:open_graph, open_graph)
    |> render("new.html",
      changeset: OpenGraphs.change_open_graph(%OpenGraph{}, Map.from_struct(open_graph)),
      open_graph: open_graph
    )
  end

  defp sanitize_url(url) do
    uri = url |> String.trim() |> URI.parse() |> URI.to_string()
  end
end
