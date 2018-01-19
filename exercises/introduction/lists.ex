defmodule Lists do
    
    # Get the nth element of the list.
    def nth(_, []) do
        []
    end
    def nth(0, [head|_]) do
        head
    end
    def nth(n, [_|tail]) do
        nth(n-1, tail)
    end

    # Calculate the lenght of the list.
    def len(l) do
        len(0, l)
    end
    def len(n, []) do
        n
    end
    def len(n, [_|tail]) do
        len(n+1, tail)
    end

    # Assume that the list only consists of integers. Make the sum of these.
    def sum([]) do
        0
    end
    def sum([head|tail]) do
        head + sum(tail)
    end

    # Duplicate every element in the list.
    def duplicate([]) do
        []
    end
    def duplicate([head|tail]) do
        [head, head | duplicate(tail)]
    end

    # Add the element x to the list if it doesn't exist already.
    def add(x, []) do
        [x]
    end
    def add(x, [x | tail]) do
        [x | tail]
    end
    def add(x, [head | tail]) do
        [head | add(x, tail)]
    end

    # Remove element x from the list.
    def remove(_, []) do
        []
    end
    def remove(x, [x | tail]) do
        remove(x, tail)
    end
    def remove(x, [head | tail]) do
        [head | remove(x, tail)]
    end

    # Make every element in the list unique.
    def unique([]) do
        []
    end
    def unique([head | tail]) do
        [head | remove(head, tail) |> unique()]
    end

    # Pack up every same element of the list in another list within the list.
    def pack(l) do
        pack([], l, unique(l))
    end
    def pack(l, _, []) do
        l
    end
    def pack([], l, [h | t]) do
        pack([h], l, [h | t])
    end
    def pack([h1 | _], l, [h2 | t2]) do
        pack([h1 | sort(h2, [], l)], l, t2)
    end
    def sort(_, l, []) do
        l
    end
    def sort(x, [h1 | t1], [x | t2]) do
        sort(x, [h1, x | t1], t2)
    end
    def sort(x, l, [h2 | t2]) do
        sort(x, l, t2)
    end

    # Reverse the list.
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