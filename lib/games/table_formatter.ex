defmodule Games.TableFormatter do
  def print_table_for_columns(rows, headers) do
    with data_by_columns = split_into_columns(rows, headers),
         column_widths = widths_of_columns(prepare_column_count(headers, data_by_columns)),
         format = format_for(column_widths) do
      insert_row(headers, format)
      IO.puts(separator(column_widths))
      insert_columns(data_by_columns, format)
    end
  end

  defp split_into_columns(rows, headers) do
    for header <- headers do
      for row <- rows, do: make_printable(row[header])
    end
  end

  defp make_printable(str) when is_binary(str), do: str
  defp make_printable(str), do: to_string(str)

  defp prepare_column_count(headers, data_by_columns) do
    Enum.zip(headers, data_by_columns)
    |> Enum.map(&[elem(&1, 0) | elem(&1, 1)])
  end

  defp widths_of_columns(columns) do
    for column <- columns,
        do:
          column
          |> Enum.map(&String.length/1)
          |> Enum.max()
  end

  defp format_for(column_widths) do
    Enum.map_join(column_widths, " | ", &"~-#{&1}s") <> "~n"
  end

  defp separator(column_widths) do
    Enum.map_join(column_widths, "-+-", &List.duplicate("-", &1))
  end

  defp insert_columns(data_by_columns, format) do
    data_by_columns
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.each(&insert_row(&1, format))
  end

  defp insert_row(fields, format) do
    :io.format(format, fields)
  end
end
