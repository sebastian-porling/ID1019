defmodule Benchr do
    
    def bench() do
        ls = [16, 32, 64, 128, 256, 512]
        n = 100
        # bench is a closure - function with an environment
        bench = fn(l) ->
            seq = :lists.seq(1,l)
            tn = time(n, fn() -> nreverse(seq) end)
            tr = time(n, fn() -> reverse(seq) end)
            :io.format("length: ~10w  nrev: ~8w us rev: ~8w us~n", [l, tn, tr])
        end
        # We use the library function Enum.each that
        # will call bench(l) for each element l in ls
        Enum.each(ls, bench)
    end
    def time(n, fun) do
        start = System.monotonic_time(:milliseconds)
        loop(n, fun)
        stop = System.monotonic_time(:milliseconds)
        (stop - start)
    end
    def loop(n, fun) do
        if n == 0 do
            :ok else
            fun.()
            loop(n-1, fun)
        end
    end

    # 
    def reverse(l) do
        reverse(l, [])
    end
    def reverse([], r) do
        r
    end
    def reverse([head | tail], r) do
        reverse(tail, [head|r])
    end

    # Naive reverse takes more time because each append operation takes O(n) so this function will take O(n^2).
    # While the better reverse function will take O(n).
    def nreverse([]) do [] end
    def nreverse([h|t]) do
    r = nreverse(t)
    r ++ [h]
    end

    # to_binary is the same as the reverse function. But this will take O(n log n).
    # The to_better function will take O(log n).
    def to_binary(0) do [0]  end
    def to_binary(n) do
        to_binary(div(n,2)) ++ [rem(n,2)]
    end

    def to_better(n) do
        to_better(n, [])
    end
    def to_better(0, l) do l end
    def to_better(n, l) do
        to_better(div(n,2), [rem(n,2)|l])
    end

    def to_integer(l) do
        to_integer(reverse(l), 0)
    end
    def to_integer([], n) do 0 end
    def to_integer([h|t], n) when h == 1 do
        exp_fast(2, n) + to_integer(t, n+1)
    end
    def to_integer([h|t], n) do
        to_integer(t, n+1)
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

    def fib(0) do 0 end
    def fib(1) do 1 end
    def fib(2) do 1 end
    def fib(n) when rem(n, 2) == 0 do
        fib(div(n,2))*(2*fib(div(n,2)+1)-fib(div(n,2)))
    end
    def fib(n) do
        exp_fast(fib(div(n,2)+1),2) + exp_fast(fib(div(n,2)),2)
    end


end