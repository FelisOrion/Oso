defmodule Oso.Cache do

  alias Oso.Managment

  @moduledoc """
  The boundary for the Notification system.
  """
  @doc """
  funzione per caricamento del ETC come cash
  """
  def update(pid, value) do
    case Cachex.get(:cache, pid) do
      {:missing, nil } -> #se non trova setta
          Cachex.set(:cache, pid, value)
      {:ok, list} -> #altrimenti aggiorna
          Cachex.update(:cache, pid, [value | list])
    end
  end


  def get(pid, value) do
    with {:ok, list} <- Cachex.get(:cache, pid) do
      {:ok, list}
    end
  end
 @doc """
 cancello chiave dalla cash
 """
  def clean_key(pid) do
    with {:ok, true} <- Cachex.exists?(:cache, pid) do
      Cachex.del(:cache, pid)
    end
  end
end
