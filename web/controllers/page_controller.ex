defmodule LaurenHallWriting.PageController do
  use LaurenHallWriting.Web, :controller

  ~w( index about work awards contact ) |> Enum.each fn view ->
    def unquote(:"#{view}")(conn, _params), do: render conn, "#{unquote(view)}.html"
  end
end
