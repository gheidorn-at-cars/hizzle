defmodule HizzleWeb.PageController do
  use HizzleWeb, :controller

  alias Phoenix.LiveView

  def index(conn, _params) do
    render(conn, "index.html", current_user: get_session(conn, :current_user))
  end

  # def show(conn, %{"id" => id}) do
  #   LiveView.Controller.live_render(conn, HizzleWeb.ThermostatLive,
  #     session: %{
  #       id: id,
  #       current_user_id: get_session(conn, :user_id)
  #     }
  #   )
  # end
end
