defmodule ExMon.Pokemon do
  @keys [:id, :name, :weight, :types]

  @enforce_keys @keys

  @derive Jason.Encoder

  defstruct @keys

  def build(params) do
    %__MODULE__{
      id: params["id"],
      name: params["name"],
      weight: params["weight"],
      types: parse_types(params["types"])
    }
  end

  defp parse_types(types), do: Enum.map(types, fn item -> item["type"]["name"] end)
end
