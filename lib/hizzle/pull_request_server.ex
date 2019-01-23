defmodule Hizzle.PullRequestServer do
  use GenServer
  require Logger

  defmodule PullRequestState do
    defstruct name: nil, start_time: nil, status: :submitted

    @type t :: %PullRequestState{
            name: String.t(),
            start_time: any(),
            status: String.t()
          }
  end

  # Client Interface

  @doc """
  Spawns a new migration server process registered under the given `pr_name`.
  """
  def start_link(pr_name) do
    GenServer.start_link(
      __MODULE__,
      %PullRequestState{name: pr_name, start_time: DateTime.utc_now()},
      name: via_tuple(pr_name)
    )
  end

  @doc """
  Returns a tuple used to register and lookup a PullRequestServer process by name.
  """
  def via_tuple(pr_name) do
    {:via, Registry, {Hizzle.PullRequestRegistry, pr_name}}
  end

  def status(pr_name) do
    GenServer.call(via_tuple(pr_name), :status)
  end

  # Server Callbacks
  def init(pr_state) do
    pr_state =
      case :ets.lookup(:pr_table, pr_state.name) do
        [] ->
          # TODO any further initialization goes here
          :ets.insert(:pr_table, {pr_state.name, pr_state})
          pr_state

        [{_, pr_state}] ->
          pr_state
      end

    Logger.info("Spawned PullRequestServer process named '#{pr_state.name}'.")

    {:ok, pr_state}
  end
end
