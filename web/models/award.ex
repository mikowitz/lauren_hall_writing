defmodule LaurenHallWriting.Award do
  use LaurenHallWriting.Web, :model

  schema "awards" do
    field :title, :string
    field :description, :string
    field :year, :integer

    timestamps
  end

  # validate award, title: present(), description: present()

  @required_fields ~w(title description year)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_length(:title, min: 1)
    |> validate_length(:description, min: 1)
  end
end
