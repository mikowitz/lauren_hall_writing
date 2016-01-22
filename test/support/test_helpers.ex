defmodule LaurenHallWriting.TestHelpers do
  alias LaurenHallWriting.Repo
  alias LaurenHallWriting.Award
  alias LaurenHallWriting.User
  alias LaurenHallWriting.Publication

  def insert_user(attrs \\ %{}) do
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

  def insert_publication() do
    changes = %{
      title: "Poem #{random8()}",
      link: "http://laurenhallwriting.com",
      journal: "Journal #{random8()}"
    }

    %Publication{}
    |> Publication.changeset(changes)
    |> Repo.insert!()
  end


  defp random8(), do: Base.encode16(:crypto.rand_bytes(8))
end
