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

end
