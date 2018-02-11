defmodule Test do
    
    def demo() do
        #small(-2.6, 1.2, 1.2)
        #small(-0.8218,0.20011,-0.82145)
    end
    def small({x0, y0, xn}) do
        width = 4960
        height = 3040
        depth = 1000
        k = (xn - x0) / width
        image = Mandel.mandelbrot(width, height, x0, y0, k, depth)
        PPM.write("test1.ppm", image)
    end
    def img(:mandel) do
        {-2.6, 1.2, 1.2}
    end
    def img(:forest) do
        {-0.136,0.85,-0.134}
    end
    def img(:waves) do
        {-0.14,0.85,-0.13}
    end
    def img(:test) do
        {-0.8218,0.20011,-0.82145}
    end
end