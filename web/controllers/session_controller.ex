defmodule LaurenHallWriting.SessionController do
  use LaurenHallWriting.Web, :controller

  def new(conn, _) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"username" => user, "password" => pass}}) do
    case LaurenHallWriting.Auth.login_by_username_and_pass(conn, user, pass, repo: Repo) do
      {:ok, conn} ->
        conn
        # |> redirect(to: admin_path(conn, :index))
        |> redirect(to: page_path(conn, :index))
      {:error, _reason, conn} ->
        conn
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> LaurenHallWriting.Auth.logout()
    |> redirect(to: page_path(conn, :index))
  end
end
