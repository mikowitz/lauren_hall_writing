defmodule LaurenHallWriting.ContactController do
  use LaurenHallWriting.Web, :controller

  plug :scrub_params, "contact"

  def create(conn, %{"contact" => contact_params}) do
    case Dict.fetch(contact_params, "confirmation") do
      {:ok, "IAMNOTAROBOT"} ->
        contact_params
        |> LaurenHallWriting.Mailer.send_contact_email

        conn
        |> put_flash(:info, "Thank you for contacting Lauren!")
        |> redirect(to: page_path(conn, :about))
      _ ->
        conn
        |> put_flash(:error, "Please prove that you are not a robot")
        |> redirect(to: page_path(conn, :contact))
    end
  end
end
