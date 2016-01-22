defmodule LaurenHallWriting.Repo.Migrations.CreatePublication do
  use Ecto.Migration

  def change do
    create table(:publications) do
      add :title, :string
      add :link, :string
      add :journal, :string
      add :issue, :string
      add :position, :integer

      timestamps
    end

  end
end
