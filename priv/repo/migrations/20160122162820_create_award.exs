defmodule LaurenHallWriting.Repo.Migrations.CreateAward do
  use Ecto.Migration

  def change do
    create table(:awards) do
      add :title, :string
      add :description, :text
      add :position, :integer

      timestamps
    end

  end
end
