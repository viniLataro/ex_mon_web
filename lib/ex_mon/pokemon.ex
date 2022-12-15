defmodule ExMon.Pokemon do
  @keys [:id, :name, :weigth, :types]

  @enforce_keys @keys

  defstruct @keys

  def build(%{"id" => id, "name" => name, "weigth" => weigth, "Types" => types}) do
    %__MODULE__{
      id: id,
      name: name,
      weigth: weigth,
      types: parse_types(types)
    }
  end

  defp parse_types(types), do: Enum.map(types, fn item -> item["type"]["name"] end)
end