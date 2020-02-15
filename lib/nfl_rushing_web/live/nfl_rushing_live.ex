defmodule NflRushingWeb.NflRushingLive do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    {:ok, data} = File.read!(Path.relative_to_cwd("rushing.json")) |> Jason.decode()
    {:ok, assign(socket, %{data: data, value: ""})}
  end

  def render(assigns) do
    Phoenix.View.render(NflRushingWeb.NflLiveView, "index.html", assigns)
  end

  def handle_params(%{"sort_by" => sort_by}, _uri, socket) do
    case sort_by do
      sort_by
      when sort_by in ~w(TD Lng Yds) ->
        {:noreply, assign(socket, data: sort_players(socket.assigns.data, sort_by))}

      _ ->
        {:noreply, socket}
    end
  end

  def handle_params(%{"player-name" => name}, _uri, socket) do
    {:ok, data} = File.read!(Path.relative_to_cwd("rushing.json")) |> Jason.decode()

    case String.trim(name) do
      "" ->
        {:noreply, assign(socket, :data, data)}

      _ ->
        {:noreply,
         assign(
           socket,
           :data,
           Enum.filter(data, fn d ->
             String.contains?(String.downcase(d["Player"]), String.downcase(name))
           end)
         )}
    end
  end

  def handle_params(_params, _uri, socket) do
    {:noreply, socket}
  end

  def handle_event("export", _, socket) do
    {:noreply, assign(socket, :temperature, "")}
  end
  def sort_players(data, sort_by) do
    Enum.sort_by(data, fn data -> data[sort_by] end)
  end

end
