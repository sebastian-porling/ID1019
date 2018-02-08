defmodule Color do
    @spec convert(integer(), integer()) :: {:rgb, integer(), integer(), integer()}

    def convert(depth, max) do
        a = ((depth / max) * 4)
        x = trunc(a)
        y = trunc(255*(a - x))

        case x do
            0 -> {:rgb, y, 0, 0}
            1 -> {:rgb, 255, y, 0}
            2 -> {:rgb, 255 - y, 255, 0}
            3 -> {:rgb, 0, 255, y}
            4 -> {:rgb, 0, 255 - y, 255}
        end
    end

end