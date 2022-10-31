defmodule LunaApp.OpenGraphs.OpenGraph do
  use Ecto.Schema
  import Ecto.Changeset

  schema "open_graphs" do
    field :url, :string
    field :image, :string
    field :title, :string, default: ""
    field :type, :string, default: "website"
    field :status, :string, default: "pending"
    field :metadata, :map, default: nil

    timestamps()
  end

  @doc false
  @changeset_params [:id, :url, :image, :title, :type, :status, :metadata]
  @allowed_status [
    "pending",
    "processing",
    "ready",
    "error"
  ]
  def changeset(open_graph, attrs) do
    open_graph
    |> cast(attrs, @changeset_params)
    |> validate_required([:url, :status])
    |> validate_inclusion(:status, @allowed_status)
  end
end
