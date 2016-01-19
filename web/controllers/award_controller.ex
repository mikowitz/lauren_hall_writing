defmodule LaurenHallWriting.AwardController do
  use LaurenHallWriting.Web, :controller
  alias LaurenHallWriting.Award

  def new(conn, _params) do
    changeset = Award.changeset(%Award{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"award" => award_params}) do
    changeset = Award.changeset(%Award{}, award_params)

    case Repo.insert(changeset) do
      {:ok, award} ->
        conn
        |> redirect(to: page_path(conn, :awards))
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end
end
