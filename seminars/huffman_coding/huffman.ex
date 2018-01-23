defmodule Huffman do
    def alfabet do 
        %{'a' => 0, 'b' => 0, 'c' => 0, 'd' => 0, 
        'e' => 0, 'f' => 0, 'g' => 0, 'h' => 0, 'j' => 0, 'l' => 0,
        'k' => 0, 'm' => 0, 'n' => 0, 'o' => 0, 'p' => 0, 'q' => 0,
        'r' => 0, 's' => 0, 't' => 0, 'u' => 0, 'v' => 0, 'w' => 0,
        'x' => 0, 'y' => 0, 'z' => 0}
    end
    def sample do
        'the quick brown fox jumps over the lazy dog this is a sample text that we will use when we build up a table we will only handle lower case letters and no punctuation symbols the frequency will of course not represent english but it is probably not that far off'
    end
    def text, do: 'this is something that we should encode'
    def test do
        sample = sample()
        tree = tree(sample)
        encode = encode_table(tree)
        decode = decode_table(tree)
        text = text()
        seq = encode(text, encode)
        decode(seq, decode)
    end
    def tree(sample) do
        freq = freq(sample)
        ##huffman(freq)
    end
    def encode_table(tree) do
        # To implement...
    end
    def decode_table(tree) do
        # To implement...
    end
    def encode(text, table) do
        # To implement...
    end
    def decode(seq, tree) do
        # To implement...
    end
    def freq(sample) do
        freq(sample, alfabet(), alfabet())
    end
    def freq([], freq, freq) do
        freq
    end
    def freq([char | rest], freq) do
        ##freq[char] = freq[char] + 1
        freq(rest, freq)
    end

    def huffman() do
        
    end
end