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
    |> add_position
  end

  def add_position(changeset) do
    case changeset.model.position do
      nil ->
        changeset
        |> put_change(:position, last_position + 1)
      _ ->
        changeset
    end
  end

  def move_up(model) do
    case Repo.get_by(Award, position: model.position - 1) do
      nil ->
        model
      previous_award ->
        position_one = model.position
        position_two = previous_award.position
        model
        |> cast(%{}, [], [])
        |> put_change(:position, position_two)
        |> Repo.update

        previous_award
        |> cast(%{}, [], [])
        |> put_change(:position, position_one)
        |> Repo.update
    end
  end

  def move_down(model) do
    case Repo.get_by(Award, position: model.position + 1) do
      nil ->
        model
      next_award ->
        position_one = model.position
        position_two = next_award.position
        model
        |> cast(%{}, [], [])
        |> put_change(:position, position_two)
        |> Repo.update

        next_award
        |> cast(%{}, [], [])
        |> put_change(:position, position_one)
        |> Repo.update
    end
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
