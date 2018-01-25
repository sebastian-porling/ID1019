defmodule Huffman do
    def alfabet do
        ' abcdefghjlkmnlopqrstuvwxyzåäö'
    end
    def sample do
        'the quick brown fox jumps over the lazy dog this is a sample text that we will use when we build up a table we will only handle lower case letters and no punctuation symbols the frequency will of course not represent english but it is probably not that far off'
    end
    def text, do: 'this is something that we should encode'
    def test do
        sample = sample()
        tree = tree(sample)
        encode = encode_table(tree)
        #decode = decode_table(tree)
        text = text()
        seq = encode(text, encode)
        decode(seq, encode)
    end
    def tree(sample) do
        freq = freq(sample)
        huffman(freq)
    end
    def encode_table([tree]) do
        make_table(elem(tree, 1), [])
    end
    def make_table({l,r}, bin) do
        lt = make_table(l, [0 | bin])
        rt = make_table(r, [1 | bin])
        lt ++ rt
    end
    def make_table(element, bin) do
        [{element, reverse(bin)}]
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

    def decode_table(tree) do
        # To implement...
    end
    def encode(text, table) do
        encode(text, table, table)
    end
    def encode([], _, _) do [] end 
    def encode([e|t], [{e,bin}|t2], table) do
        bin ++ encode(t, table, table)
    end
    def encode(charlist, [h|t], table) do
        encode(charlist, t, table)
    end

    def decode([], _), do: []
    def decode(seq, table) do
        {char, rest} = decode_char(seq, 1, table)
        [char | decode(rest, table)]
    end
    def decode_char(seq, n, table) do
        {code, rest} = Enum.split(seq, n)
        case List.keyfind(table, code, 1) do
            {char, _} ->
                {char, rest}; 
            nil ->
                decode_char(seq, n+1, table)
        end 
    end
    def freq(sample) do
        freq(sample ++ alfabet(), [])
    end
    def freq([], freq) do
        freq
    end
    def freq([char | rest], freq) do
        freq(rest, add_freq(char, freq))
    end

    def add_freq(char, []) do
        [{1, char}]
    end
    def add_freq(char, [{f, char}|t]) do
        [{f+1, char}|t]
    end
    def add_freq(char, [h|t]) do
        [h|add_freq(char, t)]
    end


    # Assume that the list is sorted, put n in the right place in the list.
    def insert(n, []) do
        [n]
    end 
    def insert({f, c}, [{hf, hc} | tail]) when f <= hf do
        [{f, c}, {hf, hc} | tail]
    end
    def insert({f, c}, [{hf, hc} | tail]) when f > hf do 
        [{hf, hc} | insert({f, c}, tail)]
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

    def huffman(freq) do
        freq = isort(freq)
        huff(freq)
    end

    def huff([x]) do
        [x]
    end
    def huff([{f1, c1}, {f2, c2} | tail]) do
        #huff(insert_tree({f1+f2, {{:left, f1, c1}, {:right, f2, c2}}}, tail))
        huff(insert_tree({f1+f2, {c1, c2}}, tail))
    end

    def insert_tree(n, []) do
        [n]
    end
    def insert_tree({f, tup}, [{f2, tup2}|t]) when f <= f2 do
        [{f, tup}, {f2, tup2} | t]
    end
    def insert_tree({f, tup}, [{f2, tup2}|t]) when f > f2 do
        [{f2, tup2} | insert({f, tup}, t)]
    end

    def test_tree() do
        tree(text())
    end

    def read(file, n) do
        {:ok, file} = File.open(file, [:read])
        binary = IO.read(file, n)
        File.close(file)
        case :unicode.characters_to_list(binary, :utf8) do
            {:incomplete, list, _} ->
                list; 
            list ->
                list
                tree = tree(list)
                encode = encode_table(tree)
                #ecode = decode_table(tree)
                text = text()
                seq = encode(text, encode)
                decode(seq, encode)
        end 
    end

end