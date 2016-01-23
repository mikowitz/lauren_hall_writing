defmodule LaurenHallWriting.Mailer do
  use Mailgun.Client,
  domain: Application.get_env(:lauren_hall_writing, :mailgun_domain),
  key: Application.get_env(:lauren_hall_writing, :mailgun_key)

  @to "lauren.hall@gmail.com"
  @from "noreply@mg.laurenhallwriting.com"

  def send_contact_email(%{"email" => email, "message" => message, "name" => name}) do
    send_email(to: @to,
               from: @from,
               subject: "[laurenhallwriting.com] You have a new message from #{name}",
               text: "#{name} (#{email}) wrote: #{message}"
    )
  end
end
