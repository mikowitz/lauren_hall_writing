defmodule LaurenHallWriting.AwardTest do
  use LaurenHallWriting.ModelCase

  alias LaurenHallWriting.Award

  @valid_attrs %{description: "some content", title: "some content", year: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Award.changeset(%Award{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Award.changeset(%Award{}, @invalid_attrs)
    refute changeset.valid?
  end
end
