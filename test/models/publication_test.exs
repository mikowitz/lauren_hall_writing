defmodule LaurenHallWriting.PublicationTest do
  use LaurenHallWriting.ModelCase

  alias LaurenHallWriting.Publication

  @valid_attrs %{issue: "some content", journal: "some content", link: "some content", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Publication.changeset(%Publication{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Publication.changeset(%Publication{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "inserts an index of 1 when the publication is the first one" do
    publication = Publication.changeset(%Publication{}, @valid_attrs) |> Repo.insert!
    assert 1 == publication.position
  end

  test "inserts the next index for position when publications already exist" do
    insert_publication
    publication = Publication.changeset(%Publication{}, @valid_attrs) |> Repo.insert!
    assert 2 == publication.position
  end

  test "moving an publication down" do
    publication1 = insert_publication
    publication2 = insert_publication

    assert 1 == publication1.position
    assert 2 == publication2.position

    Publication.move_down(publication1)

    assert %Publication{position: 2} = Repo.get!(Publication, publication1.id)
    assert %Publication{position: 1} = Repo.get!(Publication, publication2.id)
  end

  test "moving an publication down when it's already the last one" do
    publication1 = insert_publication
    publication2 = insert_publication

    assert 1 == publication1.position
    assert 2 == publication2.position

    Publication.move_down(publication2)

    assert %Publication{position: 1} = Repo.get!(Publication, publication1.id)
    assert %Publication{position: 2} = Repo.get!(Publication, publication2.id)
  end

  test "moving an publication up" do
    publication1 = insert_publication
    publication2 = insert_publication

    assert 1 == publication1.position
    assert 2 == publication2.position

    Publication.move_up(publication2)

    assert %Publication{position: 2} = Repo.get!(Publication, publication1.id)
    assert %Publication{position: 1} = Repo.get!(Publication, publication2.id)
  end

  test "moving an publication up when it's already the first one" do
    publication1 = insert_publication
    publication2 = insert_publication

    assert 1 == publication1.position
    assert 2 == publication2.position

    Publication.move_up(publication1)

    assert %Publication{position: 1} = Repo.get!(Publication, publication1.id)
    assert %Publication{position: 2} = Repo.get!(Publication, publication2.id)
  end
end
