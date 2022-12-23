f = readlines("day10.txt")

function cycle_update(f)
    n = length(f)
    X = [1]
    for i in 1:n
        if startswith(f[i], "noop")
            push!(X, X[end])
        else
            push!(X, X[end])
            ncycles = parse(Int, split(f[i], " ")[2])
            push!(X, X[end]+ncycles)
        end
    end
    return(X)
end
cycles = [20, 60, 100, 140, 180, 220]
X = cycle_update(f)
println("Part 1: ", sum(cycles .* X[cycles]))


#Part 2

function draw_CRT(X::Vector{Int})
    CRT = Matrix{Int}(undef, (6, 40))
    n = length(X)
    row = 0
    for i in 1:n
        col = mod(i-1, 40)+1
        if col == 1
            row +=1
        end
        if col in [X[i], X[i]+1, X[i]+2]
            CRT[row, col] = 1
        end
    end
    return(CRT)
end

CRT = draw_CRT(X)
println("Part 2:")
display(CRT)
println()
