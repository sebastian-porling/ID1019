defmodule Foo do
    def tic() do
        receive do
            :tic ->
                IO.puts "tic"
                tic()
            :tac ->
                IO.puts "tac"
                tic()
            :toe ->
                IO.puts "ok"
                toe()
        end
    end
    def toe() do
        receive do
            message ->
                IO.puts "toe"
                tic()
        end
        
    end
end