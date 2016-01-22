defmodule LaurenHallWriting.PublicationControllerTest do
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

  alias LaurenHallWriting.Publication
  @valid_attrs %{issue: "some content", journal: "some content", link: "some content", position: 42, title: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, publication_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing publications"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, publication_path(conn, :new)
    assert html_response(conn, 200) =~ "New publication"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, publication_path(conn, :create), publication: @valid_attrs
    assert redirected_to(conn) == publication_path(conn, :index)
    assert Repo.get_by(Publication, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, publication_path(conn, :create), publication: @invalid_attrs
    assert html_response(conn, 200) =~ "New publication"
  end

  test "shows chosen resource", %{conn: conn} do
    publication = Repo.insert! %Publication{}
    conn = get conn, publication_path(conn, :show, publication)
    assert html_response(conn, 200) =~ "Show publication"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, publication_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    publication = Repo.insert! %Publication{}
    conn = get conn, publication_path(conn, :edit, publication)
    assert html_response(conn, 200) =~ "Edit publication"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    publication = Repo.insert! %Publication{}
    conn = put conn, publication_path(conn, :update, publication), publication: @valid_attrs
    assert redirected_to(conn) == publication_path(conn, :show, publication)
    assert Repo.get_by(Publication, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    publication = Repo.insert! %Publication{}
    conn = put conn, publication_path(conn, :update, publication), publication: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit publication"
  end

  test "deletes chosen resource", %{conn: conn} do
    publication = Repo.insert! %Publication{}
    conn = delete conn, publication_path(conn, :delete, publication)
    assert redirected_to(conn) == publication_path(conn, :index)
    refute Repo.get(Publication, publication.id)
  end

  @tag :public
  test "redirects home if there's no admin signed in", %{conn: conn} do
    conn = get conn, publication_path(conn, :index)
    assert redirected_to(conn) == page_path(conn, :about)
  end
end
