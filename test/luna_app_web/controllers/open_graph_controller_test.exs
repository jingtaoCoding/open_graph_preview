defmodule LunaAppWeb.OpenGraphControllerTest do
  use LunaAppWeb.ConnCase

  import LunaApp.OpenGraphsFixtures

  @create_attrs %{image: "some image", url: "some url"}
  @update_attrs %{image: "some updated image", url: "some updated url"}
  @invalid_attrs %{image: nil, url: nil}

  describe "index" do
    test "lists all open_graphs", %{conn: conn} do
      conn = get(conn, Routes.open_graph_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Open graphs"
    end
  end

  describe "new open_graph" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.open_graph_path(conn, :new))
      assert html_response(conn, 200) =~ "New Open graph"
    end
  end

  describe "create open_graph" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.open_graph_path(conn, :create), open_graph: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.open_graph_path(conn, :show, id)

      conn = get(conn, Routes.open_graph_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Open graph"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.open_graph_path(conn, :create), open_graph: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Open graph"
    end
  end

  describe "edit open_graph" do
    setup [:create_open_graph]

    test "renders form for editing chosen open_graph", %{conn: conn, open_graph: open_graph} do
      conn = get(conn, Routes.open_graph_path(conn, :edit, open_graph))
      assert html_response(conn, 200) =~ "Edit Open graph"
    end
  end

  describe "update open_graph" do
    setup [:create_open_graph]

    test "redirects when data is valid", %{conn: conn, open_graph: open_graph} do
      conn =
        put(conn, Routes.open_graph_path(conn, :update, open_graph), open_graph: @update_attrs)

      assert redirected_to(conn) == Routes.open_graph_path(conn, :show, open_graph)

      conn = get(conn, Routes.open_graph_path(conn, :show, open_graph))
      assert html_response(conn, 200) =~ "some updated image"
    end

    test "renders errors when data is invalid", %{conn: conn, open_graph: open_graph} do
      conn =
        put(conn, Routes.open_graph_path(conn, :update, open_graph), open_graph: @invalid_attrs)

      assert html_response(conn, 200) =~ "Edit Open graph"
    end
  end

  describe "delete open_graph" do
    setup [:create_open_graph]

    test "deletes chosen open_graph", %{conn: conn, open_graph: open_graph} do
      conn = delete(conn, Routes.open_graph_path(conn, :delete, open_graph))
      assert redirected_to(conn) == Routes.open_graph_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.open_graph_path(conn, :show, open_graph))
      end
    end
  end

  defp create_open_graph(_) do
    open_graph = open_graph_fixture()
    %{open_graph: open_graph}
  end
end
