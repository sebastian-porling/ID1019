defmodule Chopstick do
    def start do
        stick = spawn_link(fn -> available() end)
    end
    def available() do
        receive do
            {:request, from} -> 
                IO.puts "takes chopstick"
                send(from, :granted)
                Chopstick.gone()
            :quit -> 
                IO.puts "quits"
                :ok
        end
    end
    def gone() do
        receive do
            :return -> 
                IO.puts "returns chopstick"
                Chopstick.available()
            :quit -> 
                IO.puts "quits"
                :ok
        end
    end
    def request(stick) do
        send stick, {:request, self()}
        receive do
            :granted -> 
                :ok
        end
    end
    def quit(stick) do
        send(stick, :quit)
    end
    def return(stick) do
        send(stick, :return)
    end
end
