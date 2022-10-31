defmodule LunaApp.OpenGraphs.Parser do
  alias LunaApp.OpenGraphs
  alias LunaApp.OpenGraphs.OpenGraph, as: Graph

  def fetch(%Graph{url: url} = graph) do
    # Process.sleep(3000)

    case OpenGraph.fetch(url) do
      {:ok, og} ->
        raw_params = Map.from_struct(og)
        params = Map.merge(raw_params, %{url: url, status: "ready", metadata: raw_params})
        OpenGraphs.update_open_graph(graph, params)

      _ ->
        OpenGraphs.update_open_graph(graph, %{status: "error"})
    end
  end
end
