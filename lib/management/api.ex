defmodule Oso.Api do
  use HTTPoison.Base
  @moduledoc """
  Module for API calls wrapping HTTPoison Base
  """

  @expected_fields ~w()

  def process_url(url, query) do
    "https://test.ognisportoltre.it/api" <> url <>".json" <> query
  end

  def process_response_body(body) do
    body
    |> Poison.decode!
    |> Map.take(@expected_fields)
    |> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)
  end

end
