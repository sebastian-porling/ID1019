defmodule Eager do
    
    # If the expression is an atom return the atom
    def eval_expr({:atm, id}, _, _)  do
        {:ok, id}
    end
    # If the expression is a variable look if it exists and return its value
    # Else return error
    def eval_expr({:var, id}, env, _) do
        case Env.lookup(id, env)  do
            nil ->
                :error
            {_, str} ->
                {:ok, str}
        end
    end
    # If the expression is list/tuple go through it's elements.
    def eval_expr({:cons, rt, lt}, env, prg) do
        case eval_expr(rt, env, prg) do
            :error ->
                :error
            {:ok, rs} ->
                case eval_expr(lt, env, prg) do
                    :error ->
                        :error
                    {:ok, ls} ->
                        {:ok, {rs, ls}}
                end
        end
    end
    def eval_expr({:case, expr, cls}, env, prg) do
        case eval_expr(expr, env, prg)  do
            :error -> 
                :error
            {:ok, str} ->
                eval_cls(cls, str, env, prg)
        end 
    end

      def eval_expr({:lambda, par, free, seq}, env, prg) do
        case Env.closure(free, env) do
        :error ->
            :error
        closure ->
            {:ok, {:closure, par, seq, closure}}
        end 
    end

    def eval_expr({:apply, expr, args}, env, prg) do
        case eval_expr(expr, env, prg) do
            :error ->
                :error
            {:ok, {:closure, par, seq, closure}} ->
                case eval_args(args, env, prg) do
                    :error ->
                        :error
                    strs ->
                        env = Env.args(par, strs, closure)
                        eval_seq(seq, env, prg)
                end
        end 
    end

    def eval_expr({:call, id, args}, env, prg) when is_atom(id) do
        case List.keyfind(prg, id, 0) do
            nil ->
                :error
            {_, par, seq} ->
                case eval_args(args, env, prg) do
                    :error ->
                        :error
                    strs  ->
                        env = Env.args(par, strs, [])
                        eval_seq(seq, env, prg)
                end
        end
    end

    # Evaluates match of right side with left side.
    # If the left side is ignore then we don't evaluate the expression.
    def eval_match(:ignore, _, env) do
        {:ok, env}
    end
    # If the left side is an atom we will?
    def eval_match({:atm, id}, id, env) do
        {:ok, env}
    end
    # If the left side is a variable we evaluate the variable. 
    # If it doesn't exist we add it to the enviroment and return it
    # If its value is the same as the structure we have on right side return enviroment.
    # Otherwise fail.
    def eval_match({:var, id}, str, env) do
        case Env.lookup(id, env)  do
            nil ->
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

    # Function that evaluates clauses from case
    # If no clause matches then return error
    def eval_cls([], _, _, _) do
        :error
    end
    # Go through each clause... If it matches evaluate the sequence it has.
    def eval_cls( [{:clause, ptr, seq} | cls], str, env, prg) do
        case eval_match(ptr, str, env) do
            :fail ->
                eval_cls(cls, str, env, prg)
            {:ok, env} ->
                eval_seq(seq, env, prg)
        end 
    end

    # Function that goes through the sequence and evaluates it.
    # And evaluates the last expression.
    def eval_seq([exp], env, prg) do
        eval_expr(exp, env, prg)
    end
    def eval_seq([{:match, pattern, exp}|tail], env, prg) do
        case eval_expr(exp, env, prg) do
           :error -> 
                :error
            {:ok, str}  ->
                vars = extract_vars(pattern)
                env = Env.remove(vars, env)
                case eval_match(pattern, str, env) do
                    :fail ->
                        :error
                    {:ok, env} ->
                        eval_seq(tail, env, prg)
                end 
        end
    end
    # Function that returns a list of variables.
    def extract_vars({:var, v}) do
        [{:var, v}]
    end
    def extract_vars({:cons, lt, rt}) do
        extract_vars(lt) ++ extract_vars(rt)
    end
    def extract_vars(_) do
        []
    end

    # Main function.
    def eval(seq, prg) do
        eval_seq(seq, Env.new(), prg)
    end

    def eval_args([], _, _) do
        []
    end
    def eval_args([arg | rest], env, prg) do
        case eval_expr(arg, env, prg) do
            :error ->
                :error
            {:ok, str} ->
                [str | eval_args(rest, env, prg)]
        end
    end

    # Test function.
    def test() do
        seq =  [{:match, {:var, :x}, {:atm,:a}},
                {:match, {:var, :y}, {:cons, {:var, :x}, {:atm, :b}}},
                {:match, {:cons, :ignore, {:var, :z}}, {:var, :y}},
                {:var, :z}]
        
        seq2 = [{:match, {:var, :x}, {:atm, :a}},
                {:case, {:var, :x},
                    [{:clause, {:atm, :b}, [{:atm, :ops}]},
                    {:clause, {:atm, :a}, [{:atm, :yes}]}
                    ]} 
                ]
        seq3 = [{:match, {:var, :x}, {:atm, :a}},
                {:match, {:var, :f},
                    {:lambda, [:y], [:x], [{:cons, {:var, :x}, {:var, :y}}]}},
                {:apply, {:var, :f}, [{:atm, :b}]}
                ]
         prgm = [{:append, [:x, :y],
                    [{:case, {:var, :x},
                        [{:clause, {:atm, []}, [{:var, :y}]},
                        {:clause, {:cons, {:var, :hd}, {:var, :tl}},
                            [{:cons,
                                {:var, :hd},
                                {:call, :append, [{:var, :tl}, {:var, :y}]}}]
                        }] 
                    }]
                }]
                
        seq4 = [{:match, {:var, :x},
                    {:cons, {:atm, :a}, {:cons, {:atm, :b}, {:atm, []}}}},
                {:match, {:var, :y},
                    {:cons, {:atm, :c}, {:cons, {:atm, :d}, {:atm, []}}}},
                {:call, :append, [{:var, :x}, {:var, :y}]}
                ]
        seq5 = [{:call, :append, [{:var, :x}, {:var, :y}]}]
        eval(seq4, prgm)
    end

end  