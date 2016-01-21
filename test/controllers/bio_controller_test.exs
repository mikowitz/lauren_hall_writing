defmodule LaurenHallWriting.BioControllerTest do
  use LaurenHallWriting.ConnCase

  alias LaurenHallWriting.Bio
  @valid_attrs %{content: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, bio_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing bios"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, bio_path(conn, :new)
    assert html_response(conn, 200) =~ "New bio"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, bio_path(conn, :create), bio: @valid_attrs
    assert redirected_to(conn) == bio_path(conn, :index)
    assert Repo.get_by(Bio, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, bio_path(conn, :create), bio: @invalid_attrs
    assert html_response(conn, 200) =~ "New bio"
  end

  test "shows chosen resource", %{conn: conn} do
    bio = Repo.insert! %Bio{}
    conn = get conn, bio_path(conn, :show, bio)
    assert html_response(conn, 200) =~ "Show bio"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, bio_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    bio = Repo.insert! %Bio{}
    conn = get conn, bio_path(conn, :edit, bio)
    assert html_response(conn, 200) =~ "Edit bio"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    bio = Repo.insert! %Bio{}
    conn = put conn, bio_path(conn, :update, bio), bio: @valid_attrs
    assert redirected_to(conn) == bio_path(conn, :show, bio)
    assert Repo.get_by(Bio, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    bio = Repo.insert! %Bio{}
    conn = put conn, bio_path(conn, :update, bio), bio: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit bio"
  end

  test "deletes chosen resource", %{conn: conn} do
    bio = Repo.insert! %Bio{}
    conn = delete conn, bio_path(conn, :delete, bio)
    assert redirected_to(conn) == bio_path(conn, :index)
    refute Repo.get(Bio, bio.id)
  end
end
