defmodule LaurenHallWriting.BioTest do
  use LaurenHallWriting.ModelCase

  alias LaurenHallWriting.Bio

  @valid_attrs %{content: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Bio.changeset(%Bio{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Bio.changeset(%Bio{}, @invalid_attrs)
    refute changeset.valid?
  end
end
