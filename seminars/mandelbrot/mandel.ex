defmodule Mandel do
    @type int() :: integer()
    @spec mandelbrot(int(), int(), int(), int(), int(), int()) :: list()
    def mandelbrot(width, height, x, y, k, depth) do
        trans = fn(w, h) ->
            Cmplx.new(x + k * (w - 1), y - k * (h - 1))
        end
        rows(width, height, trans, depth, [])
    end

    def rows(_width, 0, _trans, _depth, l) do
        l
    end
    def rows(width, height, trans, depth, l) do
        row = row(width, height, trans, depth, [])
        rows(width, height - 1, trans, depth, [row | l])
    end
    defp row(0, _height, _trans, _depth, l) do
        l
    end
    defp row(width, height, trans, depth, l) do
        r = Brot.mandelbrot_nif(trans.(width, height), depth)
        pixel = Color.convert(r, depth)
        row(width - 1, height, trans, depth, [pixel | l])
    end
end