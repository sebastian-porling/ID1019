defmodule Brot do
    @type real_number() :: integer()
    @type imaginary_number() :: integer()
    @type complex_number() :: {:cmplx, real_number(), imaginary_number()}

    @spec mandelbrot(complex_number(), integer()) :: integer()
    def mandelbrot(c, m) do
        z0 = Cmplx.new(0,0)
        i = 0
        test(i, z0, c, m)
    end
    
    @spec test(integer(), complex_number(), complex_number(), integer()) :: integer()
    defp test(i, _z0, _c, m) when i >= m do
        0
    end
    defp test(i, z0, c, m) do
        abs = Cmplx.abs(z0)
        if abs < 2 do
            z1 = Cmplx.add(Cmplx.sqr(z0), c)
            test(i+1, z1, c, m)
        else 
            i
        end
    end

end