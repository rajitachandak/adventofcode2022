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
println("Part 1: ", sum(cycles .* cycle_update(f)[cycles]))

#Part 2

function draw_CRT(f)
    CRT = Matrix{String}(undef, (6, 40))
    fill!(CRT, ".")
    n = length(f)
    X = [1]
    row = 1
    for i in 1:n
        col = mod(i, 40)
        if mod(i, 40) == 0
            col = 40
        end
        if startswith(f[i], "noop")
            if col in [X[end], X[end]+1, X[end]+2]
                CRT[row, col] = "#"
            end
            push!(X, X[end])
        else
            if col in [X[end], X[end]+1, X[end]+2]
                CRT[row, col] = "#"
            end
            push!(X, X[end])
            if col in [X[end], X[end]+1, X[end]+2]
                CRT[row, col] = "#"
            end
            ncycles = parse(Int, split(f[i], " ")[2])
            push!(X, X[end]+ncycles)
            if col in [X[end], X[end]+1, X[end]+2]
                CRT[row, col] = "#"
            end
        end
    end
    return(CRT)
end

CRT = draw_CRT(f)
display(CRT)
println()
