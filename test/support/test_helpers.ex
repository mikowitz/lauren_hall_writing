defmodule LaurenHallWriting.TestHelpers do
  alias LaurenHallWriting.Repo
  alias LaurenHallWriting.Award
  alias LaurenHallWriting.User

  def insert_user(attrs \\ %{}) do
    # changes = Dict.merge(%{
    #       username: "user#{Base.encode16(:crypto.rand_bytes(8))}",
    #       password: "password"
    #                  }, attrs)

    changes = %{
      username: "user#{random8()}",
      password: "password"
    }

    %User{}
    |> User.registration_changeset(changes)
    |> Repo.insert!()
  end

  def insert_award(attrs \\ %{}) do
    changes = %{
      title: "Award #{random8()}",
      description: "Just an award for #{random8()}"
    }

    %Award{}
    |> Award.changeset(changes)
    |> Repo.insert!()
  end

  defp random8(), do: Base.encode16(:crypto.rand_bytes(8))
end
