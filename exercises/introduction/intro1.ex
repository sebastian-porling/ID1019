defmodule Intro1 do

    def hello do
        :world
    end

    def world do
        :hello
    end

    def double(n) do
        n + n
    end

    def f_to_c(f) do
        (f - 32)/1.8
    end

    def rect_area(w, h) do
        w * h
    end

    def sqr_area(w) do
        rect_area(w, w)
    end

    def circle_area(r) do
        r*r*:math.pi
    end
end