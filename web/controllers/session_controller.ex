defmodule LaurenHallWriting.SessionController do
  use LaurenHallWriting.Web, :controller

  def new(conn, _) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"username" => username, "password" => password}}) do
    case LaurenHallWriting.Auth.login_by_username_and_pass(conn, username, password, repo: Repo) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "Welcome!")
        |> redirect(to: page_path(conn, :index))
      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Nope")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> LaurenHallWriting.Auth.logout()
    |> put_flash(:info, "Bye!")
    |> redirect(to: page_path(conn, :index))
  end
end
