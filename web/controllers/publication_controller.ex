defmodule LaurenHallWriting.PublicationController do
  use LaurenHallWriting.Web, :controller

  alias LaurenHallWriting.Publication

  plug :scrub_params, "publication" when action in [:create, :update]

  def index(conn, _params) do
    publications = Repo.all(from p in Publication, order_by: [desc: p.position])
    render(conn, "index.html", publications: publications)
  end

  def new(conn, _params) do
    changeset = Publication.changeset(%Publication{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"publication" => publication_params}) do
    changeset = Publication.changeset(%Publication{}, publication_params)

    case Repo.insert(changeset) do
      {:ok, _publication} ->
        conn
        |> put_flash(:info, "Publication created successfully.")
        |> redirect(to: publication_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    publication = Repo.get!(Publication, id)
    changeset = Publication.changeset(publication)
    render(conn, "edit.html", publication: publication, changeset: changeset)
  end

  def update(conn, %{"id" => id, "publication" => %{"direction" => direction}}) do
    publication = Repo.get!(Publication, id)
    case direction do
      "up" ->
        Publication.move_up(publication)
      "down" ->
        Publication.move_down(publication)
    end
    redirect(conn, to: publication_path(conn, :index))
  end

  def update(conn, %{"id" => id, "publication" => publication_params}) do
    publication = Repo.get!(Publication, id)
    changeset = Publication.changeset(publication, publication_params)

    case Repo.update(changeset) do
      {:ok, publication} ->
        conn
        |> put_flash(:info, "Publication updated successfully.")
        |> redirect(to: publication_path(conn, :show, publication))
      {:error, changeset} ->
        render(conn, "edit.html", publication: publication, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    publication = Repo.get!(Publication, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(publication)

    conn
    |> put_flash(:info, "Publication deleted successfully.")
    |> redirect(to: publication_path(conn, :index))
  end
end
