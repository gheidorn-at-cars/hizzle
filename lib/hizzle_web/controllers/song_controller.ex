defmodule HizzleWeb.SongController do
  use HizzleWeb, :controller

  plug :secure

  def index(conn, _params) do
    render(conn, "index.html")
  end

  defp secure(conn, _params) do
    user = get_session(conn, :current_user)

    case user do
      nil ->
        conn |> redirect(to: "/auth/auth0") |> halt

      _ ->
        conn
        |> assign(:current_user, user)
    end
  end
end
