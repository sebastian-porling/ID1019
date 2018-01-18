defmodule Lists do
    
    def nth(_, []) do
        []
    end
    def nth(0, [head|_]) do
        head
    end
    def nth(n, [_|tail]) do
        nth(n-1, tail)
    end

    def len(l) do
        len(0, l)
    end
    def len(n, []) do
        n
    end
    def len(n, [_|tail]) do
        len(n+1, tail)
    end

    def sum([]) do
        0
    end
    def sum([head|tail]) do
        head + sum(tail)
    end

    def duplicate([]) do
        []
    end
    def duplicate([head|tail]) do
        [head, head | duplicate(tail)]
    end

    def add(x, []) do
        [x]
    end
    def add(x, [x | tail]) do
        [x | tail]
    end
    def add(x, [head | tail]) do
        [head | add(x, tail)]
    end

    def remove(_, []) do
        []
    end
    def remove(x, [x | tail]) do
        remove(x, tail)
    end
    def remove(x, [head | tail]) do
        [head | remove(x, tail)]
    end

    def unique([]) do
        []
    end
    def unique([head | tail]) do
        [head | unique(remove(head, tail))]
    end

    def pack([]) do
        []
    end
    def pack() do
        
    end

    def reverse(l) do
        reverse(l, [])
    end

    def reverse([], r) do
        r
    end
    def reverse([head | tail], r) do
        reverse(tail, [head|r])
    end
end