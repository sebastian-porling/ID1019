defmodule Sorting do
    
    # Assume that the list is sorted, put n in the right place in the list.
    def insert(n, []) do
        [n]
    end
    def insert(n, [head | tail]) when n < head do
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
    def msort(l) do
        case l  do
            [] -> 
                [] 
            true -> 
                {left, right} = msplit(l, [], [])
                merge(msort(left), msort(right))
        end
    end
    def merg(.., ..) do   end
    def merg(.., ..) do ... end
    def merg(.., ..) do
        if ...
            merge(.., ..)
        else
            merge(.., ..)
        end 
    end
    def msplit(l, [], []) do
        case l  do
            [] ->
                {l2, l3}
            true  ->
                msplit(l, ..., ...)
        end 
    end

end