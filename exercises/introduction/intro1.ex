defmodule Intro1 do

    # Hello world.
    def hello do
        :world
    end
    def world do
        :hello
    end

    # Calculate the double of n
    def double(n) do
        n + n
    end

    # Convert farhenheit to celsius.
    def f_to_c(f) do
        (f - 32)/1.8
    end

    # Calculate the area of a rectangle.
    def rect_area(w, h) do
        w * h
    end

    # Calculate the area of a square.
    def sqr_area(w) do
        rect_area(w, w)
    end

    # Calculate the area of a circle.
    def circle_area(r) do
        r*r*:math.pi
    end
end