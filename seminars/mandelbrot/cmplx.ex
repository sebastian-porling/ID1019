defmodule Cmplx do
    @type real_number() :: integer()
    @type imaginary_number() :: integer()
    @type complex_number() :: {:cmplx, real_number(), imaginary_number()}

    @spec new(real_number, imaginary_number) :: complex_number
    def new(r, i) do
        {:cmplx, r, i}
    end

    @spec add(complex_number, complex_number) :: complex_number
    def add({:cmplx, ar, ai}, {:cmplx, br, bi}) do
        {:cmplx, ar+br, ai+bi}
    end

    @spec sqr(complex_number) :: complex_number
    def sqr({:cmplx, r, i}) do
        {:cmplx, r*r - i*i, r*i*2}
    end

    @spec  abs(complex_number) :: complex_number
    def abs({:cmplx, r, i}) do
        :math.sqrt(r*r + i*i)
    end

    def mandelbrot({:cmplx, cr, ci}, m) do
        zr = 0
        zi = 0
        test(0, zr, zi, cr, ci, m)
    end
    defp test(m, _zr, _zi, _cr, _ci, m) do
        0
    end
    defp test(i, zr, zi, cr, ci, m) do
        zr2 = zr*zr
        zi2 = zi*zi
        a2 = zr2 + zi2
        if a2 < 4.0 do
            sr = zr2 - zi2 + cr
            si = 2*zr*zi + ci
            test(i+1, sr, si, cr, ci, m)
        else
            i
        end
    end

    def mandelbrot_nif({:cmplx, cr, ci}, m) do
        Depth.test(cr, ci, m)
    end

end
