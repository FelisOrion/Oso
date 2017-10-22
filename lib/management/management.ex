defmodule Oso.Management do
  alias Oso.Api

  def get_single(id), do: Api.get!("content/#{id}.json")
  def get_by_tags(params) do
   response = HTTPoison.get!( Api.url <> "content.json?list.query=" <> "-tag(#{params})-orderByDesc(publicationDate)" )
   response.body
   |> Poison.decode!
   |> Api.decoder
  end
  #usare permalink
  def get_by_title(params) do
    response = HTTPoison.get!( Api.url <> "content.json?list.query=" <> "-title(#{params})" )
    response.body
    |> Poison.decode!
    |> Api.decoder
  end

  def generate_tags(list) do
    list
    |> Enum.map(fn({key, val})-> if key == :tag, do: val end)
    |> Enum.reduce("", fn(x, acc)-> if x != nil, do: acc <> x <> ",", else: acc <> "" end)
    # |> (fn(part <> ",") -> part end).()
    # |> 
  end
end
