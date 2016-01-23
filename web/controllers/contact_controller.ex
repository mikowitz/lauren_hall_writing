defmodule LaurenHallWriting.ContactController do
  use LaurenHallWriting.Web, :controller

  plug :scrub_params, "contact"

  def create(conn, %{"contact" => contact_params}) do
    contact_params
    |> LaurenHallWriting.Mailer.send_contact_email

    conn
    |> put_flash(:info, "Thank you for contacting Lauren!")
    |> redirect(to: page_path(conn, :about))
  end
end
