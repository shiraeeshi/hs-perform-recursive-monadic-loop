# perform-recursive-monadic-loop

There is one thing in the `dictAppAction` function's behavior that is not clear to me: seems like it doesn't wait for the `loop` function to return from recursion (at [line 25](https://github.com/shiraeeshi/hs-perform-recursive-monadic-loop/blob/60f2ce34b1ba66452ca3d08702178c6828847b60/app/Main.hs#L25)) and runs the `runStateT` function on it's result, which shouldn't be ready yet because we're still in the recursion. How does that work?
