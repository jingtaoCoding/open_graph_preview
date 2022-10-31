defmodule LunaApp.OpenGraphsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LunaApp.OpenGraphs` context.
  """

  @doc """
  Generate a open_graph.
  """
  def open_graph_fixture(attrs \\ %{}) do
    {:ok, open_graph} =
      attrs
      |> Enum.into(%{
        image: "some image",
        url: "some url"
      })
      |> LunaApp.OpenGraphs.create_open_graph()

    open_graph
  end
end
