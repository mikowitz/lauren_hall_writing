ExUnit.start

Mix.Task.run "ecto.create", ~w(-r LaurenHallWriting.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r LaurenHallWriting.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(LaurenHallWriting.Repo)

