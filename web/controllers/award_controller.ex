defmodule LaurenHallWriting.AwardController do
  use LaurenHallWriting.Web, :controller

  alias LaurenHallWriting.Award

  plug :scrub_params, "award" when action in [:create, :update]

  def index(conn, _params) do
    awards = Repo.all(from a in Award, order_by: [asc: a.position])
    render(conn, "index.html", awards: awards)
  end

  def new(conn, _params) do
    changeset = Award.changeset(%Award{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"award" => award_params}) do
    changeset = Award.changeset(%Award{}, award_params)

    case Repo.insert(changeset) do
      {:ok, _award} ->
        conn
        |> put_flash(:info, "Award created successfully.")
        |> redirect(to: award_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    award = Repo.get!(Award, id)
    changeset = Award.changeset(award)
    render(conn, "edit.html", award: award, changeset: changeset)
  end

  def update(conn, %{"id" => id, "award" => %{"direction" => direction}}) do
    award = Repo.get!(Award, id)
    case direction do
      "up" ->
        Award.move_up(award)
      "down" ->
        Award.move_down(award)
    end
    redirect(conn, to: award_path(conn, :index))
  end

  def update(conn, %{"id" => id, "award" => award_params}) do
    award = Repo.get!(Award, id)
    changeset = Award.changeset(award, award_params)

    case Repo.update(changeset) do
      {:ok, award} ->
        conn
        |> put_flash(:info, "Award updated successfully.")
        |> redirect(to: award_path(conn, :index))
      {:error, changeset} ->
        render(conn, "edit.html", award: award, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    award = Repo.get!(Award, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(award)

    conn
    |> put_flash(:info, "Award deleted successfully.")
    |> redirect(to: award_path(conn, :index))
  end
end
