# perform-recursive-monadic-loop

There is one thing in the `dictAppAction` function's behavior that is not clear to me: seems like it doesn't wait for the `loop` function to return from recursion and runs the `runStateT` function on it's result, which shouldn't be ready yet because we're still in the recursion. How does that work?
