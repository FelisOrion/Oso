defmodule OsoWeb.PageController do
  use OsoWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
