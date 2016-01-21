defmodule LaurenHallWriting.PageController do
  use LaurenHallWriting.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
