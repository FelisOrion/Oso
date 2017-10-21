defmodule Oso.Presence do
  use Phoenix.Presence, otp_app: :oso,
                        pubsub_server: Oso.PubSub
end
