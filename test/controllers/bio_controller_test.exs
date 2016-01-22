defmodule LaurenHallWriting.BioControllerTest do
  use LaurenHallWriting.ConnCase

  setup %{conn: conn} = config do
    if username = config[:public] do
      :ok
    else
      user = insert_user(username: username)
      conn = assign(conn(), :current_user, user)
      {:ok, conn: conn, user: user}
    end
  end

  alias LaurenHallWriting.Bio
  @valid_attrs %{content: "some content"}
  @invalid_attrs %{}

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, bio_path(conn, :new)
    assert html_response(conn, 200)
  end

  test "redirects from new to edit when bio exists", %{conn: conn} do
    Repo.insert! Bio.changeset(%Bio{}, @valid_attrs)
    conn = get conn, bio_path(conn, :new)
    assert redirected_to(conn) == bio_path(conn, :edit)
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, bio_path(conn, :create), bio: @valid_attrs
    assert redirected_to(conn) == bio_path(conn, :edit)
    assert Repo.get_by(Bio, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, bio_path(conn, :create), bio: @invalid_attrs
    assert html_response(conn, 200)
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    Repo.insert! Bio.changeset(%Bio{}, @valid_attrs)
    conn = get conn, bio_path(conn, :edit)
    assert html_response(conn, 200)
  end

  test "redirects from edit to new when no bio exists", %{conn: conn} do
    conn = get conn, bio_path(conn, :edit)
    assert redirected_to(conn) == bio_path(conn, :new)
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    Repo.insert! %Bio{}
    conn = put conn, bio_path(conn, :update), bio: @valid_attrs
    assert redirected_to(conn) == bio_path(conn, :edit)
    assert Repo.get_by(Bio, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    Repo.insert! %Bio{}
    conn = put conn, bio_path(conn, :update), bio: @invalid_attrs
    assert html_response(conn, 200)
  end

  @tag :public
  test "redirects home if there's no admin signed in", %{conn: conn} do
    conn = get conn, bio_path(conn, :new)
    assert redirected_to(conn) == page_path(conn, :about)
  end

end
