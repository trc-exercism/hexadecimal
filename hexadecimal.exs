defmodule Hexadecimal do

  @radix_dictionary %{
    16 => %{
      "0" => 0,
      "1" => 1,
      "2" => 2,
      "3" => 3,
      "4" => 4,
      "5" => 5,
      "6" => 6,
      "7" => 7,
      "8" => 8,
      "9" => 9,
      "a" => 10,
      "b" => 11,
      "c" => 12,
      "d" => 13,
      "e" => 14,
      "f" => 15
    }
  }

  @doc """
  Accept a string representing a hexadecimal value and returns the
  corresponding decimal value.
  It returns the integer 0 if the hexadecimal is invalid.
  Otherwise returns an integer representing the decimal value.

  ## Examples

  iex> Hexadecimal.to_decimal("invalid")
  0

  iex> Hexadecimal.to_decimal("af")
  175

  """

  @spec to_decimal(binary) :: integer
  def to_decimal(hex, radix \\ 16) do
    try do
      String.split(hex, "", trim: true)
        |> Enum.reverse
        |> Enum.with_index
        |> Enum.reduce(0, fn({value, index}, acc) -> acc + convert_value(radix, value, index) end)
    rescue
      e in RuntimeError -> 0
    end
  end

  defp convert_value(radix, value, index) do
    round(interpret_value(radix, value) * :math.pow(radix, index))
  end

  defp interpret_value(radix, value) do
    if @radix_dictionary[radix][String.downcase(value)] == nil do
      raise "Radix does not contain matching element"
    end
    @radix_dictionary[radix][String.downcase(value)]
  end
end
