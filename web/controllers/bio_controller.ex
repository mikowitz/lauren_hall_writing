defmodule LaurenHallWriting.BioController do
  use LaurenHallWriting.Web, :controller

  alias LaurenHallWriting.Bio

  plug :scrub_params, "bio" when action in [:create, :update]

  def index(conn, _params) do
    bios = Repo.all(Bio)
    render(conn, "index.html", bios: bios)
  end

  def new(conn, _params) do
    changeset = Bio.changeset(%Bio{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"bio" => bio_params}) do
    changeset = Bio.changeset(%Bio{}, bio_params)

    case Repo.insert(changeset) do
      {:ok, _bio} ->
        conn
        |> put_flash(:info, "Bio created successfully.")
        |> redirect(to: bio_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    bio = Repo.get!(Bio, id)
    render(conn, "show.html", bio: bio)
  end

  def edit(conn, %{"id" => id}) do
    bio = Repo.get!(Bio, id)
    changeset = Bio.changeset(bio)
    render(conn, "edit.html", bio: bio, changeset: changeset)
  end

  def update(conn, %{"id" => id, "bio" => bio_params}) do
    bio = Repo.get!(Bio, id)
    changeset = Bio.changeset(bio, bio_params)

    case Repo.update(changeset) do
      {:ok, bio} ->
        conn
        |> put_flash(:info, "Bio updated successfully.")
        |> redirect(to: bio_path(conn, :show, bio))
      {:error, changeset} ->
        render(conn, "edit.html", bio: bio, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    bio = Repo.get!(Bio, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(bio)

    conn
    |> put_flash(:info, "Bio deleted successfully.")
    |> redirect(to: bio_path(conn, :index))
  end
end
