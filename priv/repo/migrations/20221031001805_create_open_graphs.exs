defmodule LunaApp.Repo.Migrations.CreateOpenGraphs do
  use Ecto.Migration

  def change do
    create table(:open_graphs, primary_key: false) do
      add :id, :bigserial, primary_key: true
      add :url, :string
      add :image, :string
      add :title, :string
      add :type, :string, default: "website"
      add :status, :string, default: "pending"
      add :metadata, :map

      timestamps()
    end

    create(unique_index(:open_graphs, [:url]))
  end
end
