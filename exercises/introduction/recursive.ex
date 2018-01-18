defmodule Recursive do
    
    def product(m, n) do
        if m == 0 do
            0
        else
            n + product(m-1, n)
        end
    end

    def product2(m, n) do
        case m do
            0 ->
                0
            _ ->
                n + product2(m-1, n)
        end
    end

    def product3(0, _) do
        0
    end
    def product3(m, n) do
        n + product3(m-1, n)
    end

    def exp(_, 0) do
        1
    end
    def exp(x,y) do
        product3(x, exp(x, y-1))
    end

    def exp_fast(_, 0) do
        1
    end
    def exp_fast(x, 1) do
        x
    end
    def exp_fast(x, y) when rem(y, 2) == 0 do
       exp_fast(x, div(y, 2)) * exp_fast(x, div(y, 2)) 
    end
    def exp_fast(x, y) when rem(y, 2) == 1 do
        x * exp_fast(x, y-1)
    end

    
end