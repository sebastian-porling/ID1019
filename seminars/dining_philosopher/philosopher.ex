defmodule Philosopher do
    def start(0, _, _, name, ctrl) do
        IO.puts("#{name} is done!")
    end
    def start(hunger, r, l, name, ctrl) do
        dream(1000, name)
        wait(r, l, name)
        start(hunger-1, r, l, name, ctrl)
    end
    def dream(t, name) do
        IO.puts("#{name} is dreaming!")
        sleep(t)
    end
    def sleep(t) do  
        :timer.sleep(:rand.uniform(t))
    end
    def wait(r, l, name) do
        
        case Chopstick.request(r) do
            :ok ->
            sleep(1000)
            IO.puts("#{name} has right chopstick!")
            case Chopstick.request(l) do
                :ok ->
                sleep(1000)
                IO.puts("#{name} has left chopstick!")
                eat(name)
                IO.puts("#{name} returns chopsticks!")
                Chopstick.return(r)
                Chopstick.return(l)
            end
        end
        
    end
    def eat(name) do
        IO.puts("#{name} is eating!")
    end
end
