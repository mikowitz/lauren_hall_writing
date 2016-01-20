defmodule LaurenHallWriting.AwardController do
  use LaurenHallWriting.Web, :controller
  alias LaurenHallWriting.Award

  def index(conn, _params) do
    awards = Repo.all(Award)
    render conn, "index.html", awards: awards
  end

  def new(conn, _params) do
    changeset = Award.changeset(%Award{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"award" => award_params}) do
    changeset = Award.changeset(%Award{}, award_params)

    case Repo.insert(changeset) do
      {:ok, _award} ->
        conn
        |> redirect(to: page_path(conn, :awards))
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end

  def edit(conn, %{"id" => id}) do
    award = Repo.get_by(Award, %{id: id})
    changeset = Award.changeset(award)
    render conn, "edit.html", changeset: changeset, award: award
  end

  def update(conn, %{"id" => id, "award" => award_params}) do
    award = Repo.get_by(Award, %{id: id})
    changeset = Award.changeset(award, award_params)

    case Repo.update(changeset) do
      {:ok, _award} ->
        conn
        |> redirect(to: award_path(conn, :index))
      {:error, changeset} ->
        render(conn, "edit.html", award: award, changeset: changeset)
    end
  end
end
