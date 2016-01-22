defmodule LaurenHallWriting.PageController do
  use LaurenHallWriting.Web, :controller
  alias LaurenHallWriting.Bio
  import Ecto.Query

  def about(conn, _params) do
    case Repo.one(from b in Bio, limit: 1) do
      nil ->
        content = ""
      bio ->
        content = Earmark.to_html(bio.content)
    end
    render conn, "about.html", bio: content
  end

  def work(conn, _params) do
    render conn, "work.html"
  end

  def awards(conn, _params) do
    render conn, "awards.html"

  end

  def contact(conn, _params) do
    render conn, "contact.html"
  end
end
