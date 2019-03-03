defmodule Cache do
  use GenServer
  @name CACHE
  # Server
  @impl GenServer
  def init(_) do
    {:ok, %{}}
  end

  @impl GenServer
  def handle_cast({:put, key, values}, state) do
    {:noreply, put(state, key, values)}
  end

  @impl GenServer
  def handle_cast({:delete, key}, state) do
    {:noreply, delete(state, key)}
  end

  @impl GenServer
  def handle_cast({:clear}, _state) do
    {:noreply, %{}}
  end

  @impl GenServer
  def handle_call({:get, key}, _, state) do
    {:reply, get(state, key), state}
  end

  @impl GenServer
  def handle_call({:exists, key}, _, state) do
    {:reply, exists?(state, key), state}
  end

  # Client
  def start(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts ++ [name: CACHE])
  end

  def write(key, values) do
    GenServer.cast(@name, {:put, key, values})
  end

  def read(key) do
    GenServer.call(@name, {:get, key})
  end

  def delete(key) do
    GenServer.cast(@name, {:delete, key})
  end

  def exists?(key) do
    GenServer.call(@name, {:exists, key})
  end

  def clear() do
    GenServer.cast(@name, {:clear})
  end

  # Helpers
  defp put(mymap, key, values) do
    Map.put(mymap, key, values)
  end

  defp get(mymap, key) do
    Map.get(mymap, key)
  end

  defp delete(mymap, key) do
    Map.delete(mymap, key)
  end

  defp exists?(mymap, key) do
    Map.has_key?(mymap, key)
  end
end
