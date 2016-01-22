defmodule LaurenHallWriting.PageView do
  use LaurenHallWriting.Web, :view

  def from_markdown(md_content) do
    md_content
    |> Earmark.to_html
    |> String.replace("<a", "<a target='_blank'")
    |> raw
  end
end
