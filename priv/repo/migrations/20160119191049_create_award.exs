defmodule LaurenHallWriting.Repo.Migrations.CreateAward do
  use Ecto.Migration

  def change do
    create table(:awards) do
      add :title, :text
      add :description, :text
      add :year, :integer

      timestamps
    end

  end
end
