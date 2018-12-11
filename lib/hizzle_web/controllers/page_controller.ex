defmodule HizzleWeb.PageController do
  use HizzleWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
