defmodule LunaApp.OpenGraphs do
  @moduledoc """
  The OpenGraphs context.
  """

  import Ecto.Query, warn: false
  alias LunaApp.Repo

  alias LunaApp.OpenGraphs.OpenGraph

  @doc """
  Gets a single open_graph.

  Raises `Ecto.NoResultsError` if the Open graph does not exist.

  ## Examples

      iex> get_open_graph!(123)
      %OpenGraph{}

      iex> get_open_graph!(456)
      ** (Ecto.NoResultsError)

  """
  def get_open_graph!(id), do: Repo.get!(OpenGraph, id)

  def get_open_graph_by_url!(url), do: Repo.get_by!(OpenGraph, url: url)

  @doc """
  Creates a open_graph.

  ## Examples

      iex> create_open_graph(%{field: value})
      {:ok, %OpenGraph{}}

      iex> create_open_graph(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_open_graph(attrs \\ %{}) do
    %OpenGraph{}
    |> OpenGraph.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Create if not recorded found by url
  or return the existing one
  """
  def upsert_open_graph(%{url: url} = attrs) do
    conflict_target = [:url]
    on_conflict_changes = [updated_at: DateTime.utc_now()]

    on_conflict =
      OpenGraph
      |> where([g], g.url == ^attrs.url)
      |> update(set: ^on_conflict_changes)

    graph =
      %OpenGraph{}
      |> OpenGraph.changeset(attrs)
      |> Repo.insert!(
        on_conflict: on_conflict,
        conflict_target: conflict_target,
        returning: true
      )

    IO.inspect(graph)
    {:ok, graph}
  end

  @doc """
  Updates a open_graph.

  ## Examples

      iex> update_open_graph(open_graph, %{field: new_value})
      {:ok, %OpenGraph{}}

      iex> update_open_graph(open_graph, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_open_graph(%OpenGraph{} = open_graph, attrs) do
    open_graph
    |> OpenGraph.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a open_graph.

  ## Examples

      iex> delete_open_graph(open_graph)
      {:ok, %OpenGraph{}}

      iex> delete_open_graph(open_graph)
      {:error, %Ecto.Changeset{}}

  """
  def delete_open_graph(%OpenGraph{} = open_graph) do
    Repo.delete(open_graph)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking open_graph changes.

  ## Examples

      iex> change_open_graph(open_graph)
      %Ecto.Changeset{data: %OpenGraph{}}

  """
  def change_open_graph(%OpenGraph{} = open_graph, attrs \\ %{}) do
    OpenGraph.changeset(open_graph, attrs)
  end
end
