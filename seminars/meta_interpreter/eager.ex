defmodule Eager do
    
    # If the expression is an atom return the atom
    def eval_expr({:atm, id}, _)  do
        {:ok, id}
    end
    # If the expression is a variable look if it exists and return its value
    # Else return error
    def eval_expr({:var, id}, env) do
        case Env.lookup(id, env)  do
            nil ->
                :error
            {_, str} ->
                {:ok, str}
        end
    end
    # If the expression is list/tuple go through it's elements.
    def eval_expr({:cons, rt, lt}, env) do
        case eval_expr(rt, env) do
            :error ->
                :error
            {:ok, rs} ->
                case eval_expr(lt, env) do
                    :error ->
                        :error
                    {:ok, ls} ->
                        {:ok, {rs, ls}}
                end
        end
    end

    # 
    def eval_match(:ignore, _, env) do
        {:ok, env}
    end
    def eval_match({:atm, id}, _, env) do
        {:ok, env}
    end
    def eval_match({:var, id}, str, env) do
        case eval_expr({:var, id}, env)  do
            :error ->
                {:ok, Env.add(id, str, env)}
            {_, ^str} ->
                {:ok, env}
            {_, _} ->
                :fail
        end
    end
    def eval_match({:cons, lt, rt}, {lstr , rstr}, env) do
        #{:ok, lstr} = eval_expr(lstr, env)
        case eval_match(lt, lstr, env) do
            :fail ->
                :fail
            {:ok, env} ->
                #{:ok, rstr} = eval_expr(rstr, env)
                eval_match(rt, rstr, env)
        end
    end
    
    def eval_match(_, _, _), do: :fail

    def eval_seq([exp], env) do
        eval_expr(exp, env)
    end
    def eval_seq([{:match, pattern, exp}|tail], env) do
        case eval_expr(exp, env) do
            :error -> 
                :error
            {:ok, str}  ->
                vars = extract_vars(pattern)
                env = Env.remove(vars, env)
                case eval_match(pattern, str, env) do
                    :fail ->
                        :error
                    {:ok, env} ->
                        eval_seq(tail, env)
                end 
        end
    end

    def extract_vars({:var, v}) do
        [{:var, v}]
    end
    def extract_vars({:cons, lt, rt}) do
        extract_vars(lt) ++ extract_vars(rt)
    end
    def extract_vars(:ignore) do
        [:ignore]
    end
    def eval(seq) do
        eval_seq(seq, Env.new())
    end

    def test() do
         seq =  [{:match, {:var, :x}, {:atm,:a}},
                {:match, {:var, :y}, {:cons, {:var, :x}, {:atm, :b}}},
                {:match, {:cons, :ignore, {:var, :z}}, {:var, :y}},
                {:var, :z}]
        eval(seq)
    end

end  