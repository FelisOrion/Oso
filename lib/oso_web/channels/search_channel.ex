defmodule OsoWeb.SearchChannel do
  use OsoWeb, :channel

  alias Oso.Presence
  alias Oso.Cache

  def join("search:chat", _, socket) do
    send self(), :after_join_chat
    {:ok, socket}
  end

  def join("search:ai", _, socket) do
    send self(), :after_join_ai
    {:ok, socket}
  end

  def handle_info(:after_join_chat, socket) do
    {:ok, pid} = Presence.track(socket, socket.assigns.user, %{
      user: socket.assigns.user,
      timestamp: :os.system_time(:millisecond)
    })
    Cache.update(pid, [])
    push socket, "presence_state", Presence.list(socket)
    {:noreply, socket}
  end

  def handle_in("message:new", message, socket) do
    broadcast! socket, "message:new", %{
      user: socket.assigns.user,
      body: message,
      timestamp: :os.system_time(:millisecond)
    }
    {:noreply, socket}
  end

  def handle_info(:after_join_ai, socket) do

    {:noreply, socket}
  end

  def handle_in("tag:new", tag, socket) do

    {:noreply, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (content:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

end
