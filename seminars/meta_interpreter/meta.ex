defmodule Env do
    # Return new enviroment
    def new() do
        []
    end

    # Return an environment where the binding of the
    # variable id to the structure
    #str has been added to the environment env.
    def add(id, str, []) do
        [{id, str}]
    end
    def add(id, str, [{id, _} | tail]) do
        [{id, str} | tail]
    end
    def add(id, str, [head | tail]) do
        [head | add(id, str, tail)]
    end

    # return  either {id, str},  if  the  variable id was bound, or nil
    def lookup(_, []) do
        nil
    end
    def lookup(id, [{id, str} | _]) do
        {id, str}
    end
    def lookup(id, [_ | tail]) do
        lookup(id, tail)
    end

    # returns  an  environmant  where  all  bindings  for
    # variabels in the list ids have been removed
    def remove([], env) do
        env
    end
    def remove([id | ids], env) do
        remove(ids, sub_remove(id, env))
    end
    def sub_remove(_, []) do
        []
    end
    def sub_remove(id, [{id, _} | tail]) do
        tail
    end
    def sub_remove(id, [head | tail]) do
        [head | sub_remove(id, tail)]
    end

end