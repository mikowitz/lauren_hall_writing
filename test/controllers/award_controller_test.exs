defmodule LaurenHallWriting.AwardControllerTest do
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

  alias LaurenHallWriting.Award
  @valid_attrs %{description: "some content", title: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, award_path(conn, :index)
    assert html_response(conn, 200)
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, award_path(conn, :new)
    assert html_response(conn, 200)
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, award_path(conn, :create), award: @valid_attrs
    assert redirected_to(conn) == award_path(conn, :index)
    assert Repo.get_by(Award, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, award_path(conn, :create), award: @invalid_attrs
    assert html_response(conn, 200)
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    award = Repo.insert! %Award{}
    conn = get conn, award_path(conn, :edit, award)
    assert html_response(conn, 200)
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    award = Repo.insert! %Award{}
    conn = put conn, award_path(conn, :update, award), award: @valid_attrs
    assert redirected_to(conn) == award_path(conn, :index)
    assert Repo.get_by(Award, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    award = Repo.insert! %Award{}
    conn = put conn, award_path(conn, :update, award), award: @invalid_attrs
    assert html_response(conn, 200)
  end

  test "deletes chosen resource", %{conn: conn} do
    award = Repo.insert! %Award{}
    conn = delete conn, award_path(conn, :delete, award)
    assert redirected_to(conn) == award_path(conn, :index)
    refute Repo.get(Award, award.id)
  end

  @tag :public
  test "redirects home if there's no admin signed in", %{conn: conn} do
    conn = get conn, award_path(conn, :index)
    assert redirected_to(conn) == page_path(conn, :about)
  end
end
