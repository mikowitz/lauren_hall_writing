defmodule LaurenHallWriting.Award do
  use LaurenHallWriting.Web, :model
  alias LaurenHallWriting.Award
  alias LaurenHallWriting.Repo

  schema "awards" do
    field :title, :string
    field :description, :string
    field :position, :integer

    timestamps
  end

  @required_fields ~w(title description)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> put_change(:position, last_position + 1)
  end

  def last_position() do
    case Repo.one(from a in Award, select: max(a.position)) do
      nil ->
        0
      position ->
        position
    end
  end

end
