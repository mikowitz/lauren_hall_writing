defmodule LaurenHallWriting.BioController do
  use LaurenHallWriting.Web, :controller
  alias LaurenHallWriting.Bio

  def new(conn, _params) do
    changeset = Bio.changeset(%Bio{})
    case Repo.one(from b in Bio, limit: 1) do
      nil ->
        changeset = Bio.changeset(%Bio{})
        render conn, "new.html", changeset: changeset
      bio ->
        conn
        |> redirect(to: bio_path(conn, :edit, bio))
    end
  end

  def create(conn, %{"bio" => bio_params}) do
    changeset = Bio.changeset(%Bio{}, bio_params)

    case Repo.insert(changeset) do
      {:ok, _bio} ->
        conn
        |> redirect(to: page_path(conn, :about))
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end

  #   # case Repo.one(from b in Bio, limit: 1) do
  #   #   nil ->
  #   #     changeset = Bio.changeset(%Bio{})
  #   #     render "new.html", changeset: changeset
  #   #   bio ->
  #   #     conn
  #   #     |> redirect(to: bio_path(conn, :edit, bio))
  #   # end
  #   changeset = Bio.changeset(%Bio{})
  #   render "new.html", changeset: changeset
  # end

  def edit(conn, %{"id" => id}) do
    bio = Repo.get_by(Bio, %{id: id})
    changeset = Bio.changeset(bio, %{})
    render conn, "edit.html", changeset: changeset, bio: bio
  end
end
