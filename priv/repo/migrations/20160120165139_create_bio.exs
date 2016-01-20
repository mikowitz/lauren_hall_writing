defmodule LaurenHallWriting.Repo.Migrations.CreateBio do
  use Ecto.Migration

  def change do
    create table(:bios) do
      add :content, :binary

      timestamps
    end

  end
end
