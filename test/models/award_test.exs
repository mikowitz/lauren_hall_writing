defmodule LaurenHallWriting.AwardTest do
  use LaurenHallWriting.ModelCase

  alias LaurenHallWriting.Award

  @valid_attrs %{description: "some content", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Award.changeset(%Award{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Award.changeset(%Award{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "inserts an index of 1 when the award is the first one" do
    award = Award.changeset(%Award{}, @valid_attrs) |> Repo.insert!
    assert 1 == award.position
  end

  test "inserts the next index for position when awards already exist" do
    insert_award
    award = Award.changeset(%Award{}, @valid_attrs) |> Repo.insert!
    assert 2 == award.position
  end

  test "moving an award down" do
    award1 = insert_award
    award2 = insert_award

    assert 1 == award1.position
    assert 2 == award2.position

    Award.move_down(award1)

    assert %Award{position: 2} = Repo.get!(Award, award1.id)
    assert %Award{position: 1} = Repo.get!(Award, award2.id)
  end

  test "moving an award down when it's already the last one" do
    award1 = insert_award
    award2 = insert_award

    assert 1 == award1.position
    assert 2 == award2.position

    Award.move_down(award2)

    assert %Award{position: 1} = Repo.get!(Award, award1.id)
    assert %Award{position: 2} = Repo.get!(Award, award2.id)
  end

  test "moving an award up" do
    award1 = insert_award
    award2 = insert_award

    assert 1 == award1.position
    assert 2 == award2.position

    Award.move_up(award2)

    assert %Award{position: 2} = Repo.get!(Award, award1.id)
    assert %Award{position: 1} = Repo.get!(Award, award2.id)
  end

  test "moving an award up when it's already the first one" do
    award1 = insert_award
    award2 = insert_award

    assert 1 == award1.position
    assert 2 == award2.position

    Award.move_up(award1)

    assert %Award{position: 1} = Repo.get!(Award, award1.id)
    assert %Award{position: 2} = Repo.get!(Award, award2.id)
  end
end
