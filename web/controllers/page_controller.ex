defmodule LaurenHallWriting.PageController do
  use LaurenHallWriting.Web, :controller
  alias LaurenHallWriting.Award
  import Ecto.Query

  ~w( index about work contact ) |> Enum.each fn view ->
    def unquote(:"#{view}")(conn, _params), do: render conn, "#{unquote(view)}.html"
  end

  def awards(conn, _params) do
    awards = Repo.all(from a in Award, order_by: [desc: a.year])
    render conn, "awards.html", awards: awards
  end
end
