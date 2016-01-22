defmodule LaurenHallWriting.Publication do
  use LaurenHallWriting.Web, :model
  alias LaurenHallWriting.Publication
  alias LaurenHallWriting.Repo

  schema "publications" do
    field :title, :string
    field :link, :string
    field :journal, :string
    field :issue, :string
    field :position, :integer

    timestamps
  end

  @required_fields ~w(title link journal)
  @optional_fields ~w(issue)

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
    case Repo.get_by(Publication, position: model.position - 1) do
      nil ->
        model
      previous_publication ->
        position_one = model.position
        position_two = previous_publication.position
        model
        |> cast(%{}, [], [])
        |> put_change(:position, position_two)
        |> Repo.update

        previous_publication
        |> cast(%{}, [], [])
        |> put_change(:position, position_one)
        |> Repo.update
    end
  end

  def move_down(model) do
    case Repo.get_by(Publication, position: model.position + 1) do
      nil ->
        model
      next_publication ->
        position_one = model.position
        position_two = next_publication.position
        model
        |> cast(%{}, [], [])
        |> put_change(:position, position_two)
        |> Repo.update

        next_publication
        |> cast(%{}, [], [])
        |> put_change(:position, position_one)
        |> Repo.update
    end
  end


  def last_position() do
    case Repo.one(from p in Publication, select: max(p.position)) do
      nil ->
        0
      position ->
        position
    end
  end

  def to_markdown(%Publication{journal: journal, link: link, title: title, issue: issue}) do
    text = "#{title}<br/>_[#{journal}](#{link})_"
    case issue do
      nil ->
        text
      issue ->
        text <> ", #{issue}"
    end
  end
end
