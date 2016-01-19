defmodule LaurenHallWriting.MarkdownView do
  use LaurenHallWriting.Web, :view

  def render("index.json", %{html: html}) do
    %{html: html}
  end
end
