defmodule LunaApp.OpenGraphsTest do
  use LunaApp.DataCase

  alias LunaApp.OpenGraphs

  describe "open_graphs" do
    alias LunaApp.OpenGraphs.OpenGraph

    import LunaApp.OpenGraphsFixtures

    @invalid_attrs %{image: nil, url: nil}

    test "get_open_graph!/1 returns the open_graph with given id" do
      open_graph = open_graph_fixture()
      assert OpenGraphs.get_open_graph!(open_graph.id) == open_graph
    end

    test "get_open_graph_by_url!/1 returns the open_graph with given url" do
      open_graph = open_graph_fixture()
      assert OpenGraphs.get_open_graph_by_url!(open_graph.url) == open_graph
    end

    test "create_open_graph/1 with valid data creates a open_graph" do
      valid_attrs = %{image: "some image", url: "some url"}

      assert {:ok, %OpenGraph{} = open_graph} = OpenGraphs.create_open_graph(valid_attrs)
      assert open_graph.image == "some image"
      assert open_graph.url == "some url"
    end

    test "create_open_graph/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = OpenGraphs.create_open_graph(@invalid_attrs)
    end

    test "update_open_graph/2 with valid data updates the open_graph" do
      open_graph = open_graph_fixture()
      update_attrs = %{image: "some updated image", url: "some updated url"}

      assert {:ok, %OpenGraph{} = open_graph} =
               OpenGraphs.update_open_graph(open_graph, update_attrs)

      assert open_graph.image == "some updated image"
      assert open_graph.url == "some updated url"
    end

    test "update_open_graph/2 with invalid data returns error changeset" do
      open_graph = open_graph_fixture()

      assert {:error, %Ecto.Changeset{}} =
               OpenGraphs.update_open_graph(open_graph, @invalid_attrs)

      assert open_graph == OpenGraphs.get_open_graph!(open_graph.id)
    end

    test "delete_open_graph/1 deletes the open_graph" do
      open_graph = open_graph_fixture()
      assert {:ok, %OpenGraph{}} = OpenGraphs.delete_open_graph(open_graph)
      assert_raise Ecto.NoResultsError, fn -> OpenGraphs.get_open_graph!(open_graph.id) end
    end

    test "change_open_graph/1 returns a open_graph changeset" do
      open_graph = open_graph_fixture()
      assert %Ecto.Changeset{} = OpenGraphs.change_open_graph(open_graph)
    end
  end
end
