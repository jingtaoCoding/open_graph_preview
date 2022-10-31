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

        conn
        |> put_flash(:info, "Data is under processing ...")
        |> assign(:open_graph, open_graph)
        |> render("new.html",
          changeset: OpenGraph.changeset(%OpenGraph{}, Map.from_struct(open_graph)),
          open_graph: open_graph
        )

      {:ok, %OpenGraph{status: "processing"} = open_graph} ->
        conn
        |> put_flash(:info, "Data is under processing ...")
        |> assign(:open_graph, open_graph)
        |> render("new.html",
          changeset: OpenGraph.changeset(%OpenGraph{}, Map.from_struct(open_graph)),
          open_graph: open_graph
        )

      {:ok, %OpenGraph{status: "ready"} = open_graph} ->
        conn
        |> assign(:open_graph, open_graph)
        |> render("new.html",
          changeset: OpenGraph.changeset(%OpenGraph{}, Map.from_struct(open_graph)),
          open_graph: open_graph
        )

      {:ok, %OpenGraph{status: "error"} = open_graph} ->
        conn
        |> assign(:open_graph, open_graph)
        |> render("new.html",
          changeset: OpenGraph.changeset(%OpenGraph{}, Map.from_struct(open_graph)),
          open_graph: open_graph
        )
    end
  end

  defp sanitize_url(url) do
    uri = url |> String.trim() |> URI.parse() |> URI.to_string()
  end
end
