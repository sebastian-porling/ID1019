defmodule Sorting do
    
    # Assume that the list is sorted, put n in the right place in the list.
    def insert(n, []) do
        [n]
    end 
    def insert(n, [head | tail]) when n <= head do
        [n, head | tail]
    end
    def insert(n, [head | tail]) when n > head do 
        [head | insert(n, tail)]
    end 

    # Insertion sort.
    def isort(l) do
        isort(l, [])
    end 
    def isort([], sl) do
        sl
    end 
    def isort([head | tail], l) do
        isort(tail, insert(head, l))
    end 

    # Merge sort
    def msort([]) do
        []
    end
    def msort(l) do
        {left, right} = msplit(l, [], [])
        merge(msort(left), msort(right))
    end

    def merge([], l) do
        l
    end
    def merge(l, []) do
        l
    end
    def merge([x | t1], [h | t2]) when x < h do
        [x | merge(t1, [h | t2])]
    end
    def merge(l, [h | t2]) do
        [h | merge(l, t2)]
    end

    def msplit([], l, r) do
        {l, r}
    end
    def msplit([h|t], l, r) do
        msplit(t, [h|r], l)
    end

    def qsort([]) do
        []
    end
    def qsort([p|l]) do
        {low, high} = qsplit(p, l, [], [])
        small = qsort(low)
        large = qsort(high)
        append(small, [p|large])
    end
    def qsplit(_, [], low, high) do {low, high} end
    def qsplit(p, [h|t], low, high) when p < h do
        qsplit(p, t, low, [h|high])
    end
    def qsplit(p, [h|t], low, high) do
        qsplit(p, t, [h|low], high)
    end

    def append([],[]) do
        []
    end
    def append(low, high) do
        low ++ high
    end
end