defmodule HizzleWeb.ThermostatLive do
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
          Current temperature: <%= @temperature %>
          <button phx-click="dec" class="minus">-</button>
    """
  end

  # def mount(%{id: id, current_user_id: user_id, current_user: current_user}, socket) do
  #   case {:ok, "32"} do
  #     {:ok, temperature} ->
  #       {:ok, assign(socket, temperature: temperature, current_user: %{})}

  #     {:error, reason} ->
  #       {:error, reason}
  #   end
  # end

  def mount(session, socket) do
    IO.puts("socket => #{inspect(socket)}")
    IO.puts("session => #{inspect(session)}")

    if connected?(socket), do: :timer.send_interval(10000, self(), :tick)

    # case Thermostat.get_user_reading(user_id, id) do
    # {:ok, temperature} ->
    {:ok, assign(socket, temperature: 72, current_user: %{})}

    # {:error, reason} ->
    # {:error, reason}
    # end
  end

  def handle_info(:tick, socket) do
    IO.puts(inspect(socket))
    {:noreply, assign(socket, temperature: 72)}
  end

  def handle_event("dec", _, socket) do
    {:noreply, update(socket, :temperature, &(&1 - 1))}
  end
end
