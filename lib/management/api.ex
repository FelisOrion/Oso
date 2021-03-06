defmodule Oso.Api do
  use HTTPoison.Base
  @moduledoc """
  Module for API calls wrapping HTTPoison Base
  """
  @api_url "https://test.ognisportoltre.it/api/"

  def url, do: @api_url

  def process_url(url) do
    @api_url <> url
  end

  def process_response_body(body) do
    body
    |> Poison.decode!()
    |> decoder()
  end

  def decoder(value) when is_number(value), do: value
  def decoder(value) when is_boolean(value), do: value
  def decoder(nil), do: ""
  def decoder(value) when is_list(value) do
    value
    |> Enum.reduce([], fn(v, acc) -> acc ++ [decoder(v)] end)
  end
  def decoder(value) when is_map(value) do
    value
    |> Enum.reduce(%{}, fn({k, v}, acc) -> Map.put(acc, String.to_atom(k), decoder(v)) end)
  end
  def decoder(value) when is_bitstring(value), do: value
  def decoder(value), do: process_response_body(value)
end
