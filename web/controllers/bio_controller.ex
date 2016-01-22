defmodule LaurenHallWriting.BioController do
  use LaurenHallWriting.Web, :controller
  import Ecto.Query

  alias LaurenHallWriting.Bio

  plug :scrub_params, "bio" when action in [:create, :update]

  def new(conn, _params) do
    case bio do
      nil ->
        changeset = Bio.changeset(%Bio{})
        render(conn, "new.html", changeset: changeset)
      bio ->
        conn
        |> redirect(to: bio_path(conn, :edit))
    end
  end

  def create(conn, %{"bio" => bio_params}) do
    changeset = Bio.changeset(%Bio{}, bio_params)

    case Repo.insert(changeset) do
      {:ok, _bio} ->
        conn
        |> put_flash(:info, "Bio created successfully.")
        |> redirect(to: bio_path(conn, :edit))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, _params) do
    case bio do
      nil ->
        redirect(conn, to: bio_path(conn, :new))
      bio ->
        changeset = Bio.changeset(bio)
        render(conn, "edit.html", bio: bio, changeset: changeset)
    end
  end

  def update(conn, %{"bio" => bio_params}) do
    changeset = Bio.changeset(bio, bio_params)

    case Repo.update(changeset) do
      {:ok, bio} ->
        conn
        |> put_flash(:info, "Bio updated successfully.")
        |> redirect(to: bio_path(conn, :edit))
      {:error, changeset} ->
        render(conn, "edit.html", bio: bio, changeset: changeset)
    end
  end

  def bio, do: Repo.one(from b in Bio, limit: 1)
end
