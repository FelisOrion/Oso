defmodule OsoWeb.UserSocket do
  use Phoenix.Socket

  ## Channels
  # channel "room:*", OsoWeb.RoomChannel
  channel "search:*", OsoWeb.SearchChannel

  ## Transports
  transport :websocket, Phoenix.Transports.WebSocket
  # transport :longpoll, Phoenix.Transports.LongPoll

  def connect(%{"user" => user}, socket) do
    {:ok, assign(socket, :user, user)}
  end

  def id(_socket), do: nil
end
