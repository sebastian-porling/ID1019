defmodule Test do
    
    def demo() do
        small(-2.6, 1.2, 1.2)
        #small(-0.8218,0.20011,-0.82145)
    end
    defp small(x0, y0, xn) do
        width = 3960
        height = 2540
        depth = 200
        k = (xn - x0) / width
        image = Mandel.mandelbrot(width, height, x0, y0, k, depth)
        PPM.write("test.ppm", image)
    end
end