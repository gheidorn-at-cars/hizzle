defmodule HizzleWeb.PageControllerTest do
  use HizzleWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Hizzle"
  end
end
