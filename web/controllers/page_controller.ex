defmodule LaurenHallWriting.PageController do
  use LaurenHallWriting.Web, :controller
  alias LaurenHallWriting.Award
  alias LaurenHallWriting.Bio

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
    awards = Repo.all(from a in Award, order_by: [asc: a.position])
    render conn, "awards.html", awards: awards
  end

  def contact(conn, _params) do
    render conn, "contact.html"
  end
end
