defmodule Qik do
  @moduledoc """
  Documentation for `Qik`.
  """

  @doc """
  Split any enumerable into lists, defining your custom separator.
  ### Example 1:
  ```elixir
  Qik.split_by([1,2,3,4,5,1,2,3,4,5],3)
  # [[1, 2], [4, 5, 1, 2], [4, 5]]
  ```

  ### Example 2:
  ```elixir
  Qik.split_by('abcdi12345i.,-', ?i)
  # ['abcd', '12345', '.,-']
  ```

  """
  def split_by(enumerable, separator \\ " ") do
    split_by_acc([], [], enumerable, separator)
  end

  defp split_by_acc(acc, chunk_acc, enumerable, separator) do
    if Enum.empty?(enumerable) do
      acc ++ [chunk_acc]
    else
      ele = Enum.at(enumerable, 0)
      tail = Enum.drop(enumerable, 1)

      if ele == separator do
        split_by_acc(acc ++ [chunk_acc], [], tail, separator)
      else
        split_by_acc(acc, chunk_acc ++ [ele], tail, separator)
      end
    end
  end

  @doc """
  Range of indexes for any enumerable
  """
  def indexes(enumerable), do: 0..(Enum.count(enumerable) - 1)

  @doc """
  This function read file with file_name, replaces all CRLF with just LF.
  Additional arguments may be passed in, to do common parsing tasks.


  - Argument `file_name` is just a string, path to file
  - Argument `split` may be atom `:no` (don't split), a string, a list of strings,
    a regular expression, or a compiled pattern (used in String.split/3)
  - Argument `map` may be atom `:no` (don't map), or the function to map with
  - Argument `filter` may be atom `:no` (don't filter), or the function to filter with
  """
  def parse(file_name, split \\ "\n", map \\ :no, filter \\ :no) do
    {:ok, content} = File.read(file_name)
    clean = String.replace(content, "\r\n", "\n")

    case split do
      :no ->
        clean

      pattern ->
        split_done = String.split(clean, pattern)

        case map do
          :no ->
            split_done

          mapfn ->
            map_done = Enum.map(split_done, mapfn)

            case filter do
              :no -> map_done
              filterfn -> Enum.filter(map_done, filterfn)
            end
        end
    end
  end

  @doc """
  Convert enumerable of strings to integers
  """
  def mapint(enumerable), do: Enum.map(enumerable, &String.to_integer(&1))

  @doc """
  Convert enumerable of strings to floats
  """
  def mapfloat(enumerable), do: Enum.map(enumerable, &String.to_float(&1))
end
