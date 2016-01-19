defmodule LaurenHallWriting.MarkdownController do
  use LaurenHallWriting.Web, :controller

  def index(conn, %{"markdown" => markdown}) do
    html = Earmark.to_html(markdown)
    render conn, "index.json", html: html
  end
end
