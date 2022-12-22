f = readlines("day9.txt")
function gen_grid(f::Vector{String})
    n_u = 1
    n_d = 1
    n_r = 1
    n_l = 1
    for i in 1:length(f)
        l = split(f[i])
        if l[1] == "U"
            n_u += parse(Int,l[2])
        elseif l[1] == "R"
            n_r += parse(Int, l[2])
        elseif l[1] == "L"
            n_l += parse(Int, l[2])
        elseif l[1] == "D"
            n_d += parse(Int, l[2])
        end
    end
    n = max(n_u, n_d, n_r, n_l)
    grid = round.(Int, zeros(2*n,2*n))

    return(grid)
end

function string_path(f::Vector{String}, grid::Matrix{Int})
    #starting position
    n = trunc(Int, size(grid)[1]/2)
    curr_H = [n, n]
    curr_T = [n, n]
#    grid[n, n] = 1
    # loop through all moves
    for i in 1:3
        l = split(f[i], " ")
        if l[1] == "U"
            println(l)
            diff = curr_H .- curr_T
            println(diff)
            steps = parse(Int, l[2])
            if diff[2] == -1
                curr_H = curr_H + [0, steps]
                grid[curr_T[1]+diff[1], curr_T[2]+1] = 1
                grid[curr_T[1]+diff[1], curr_T[2]+1:(curr_T[2] + steps + 1)] .= 1
                curr_T = curr_T + [diff[1], diff[2] + steps+1]
                println(curr_H)
                println(curr_T)
            else
                curr_H = curr_H + [0, steps]
                grid[curr_T[1]+diff[1], curr_T[2]+1] = 1
                grid[curr_T[1]+diff[1], curr_T[2]+1:(curr_T[2] + steps - 1)] .= 1
                curr_T = curr_T + [diff[1], diff[2] + steps-1]
                println(curr_H)
                println(curr_T)
            end
        elseif l[1] == "R"
            println(l)
            diff = curr_H .- curr_T
            println(diff)
            steps = parse(Int, l[2])
            if diff[1] == -1
                curr_H = curr_H + [steps, 0]
                grid[curr_T[1], curr_T[2]+diff[2]] = 1
                grid[curr_T[1]:(curr_T[1] + steps + 1), curr_T[2]+diff[2]] .= 1
                curr_T = curr_T + [diff[1]+steps+1, diff[2]]
                println(curr_H)
                println(curr_T)
            else
                curr_H = curr_H + [steps, 0]
                grid[curr_T[1], curr_T[2]+diff[2]] = 1
                grid[curr_T[1]:(curr_T[1] + steps - 1), curr_T[2]+diff[2]] .= 1
                curr_T = curr_T + [diff[1]+steps-1, diff[2]]
                println(curr_H)
                println(curr_T)
            end
        elseif l[1] == "L"
            println(l)
            diff = curr_H .- curr_T
            println(diff)
            steps = -parse(Int, l[2])
            if diff[1] == 1
                curr_H = curr_H + [steps, 0]
                grid[curr_T[1], curr_T[2]+diff[2]] = 1
                grid[curr_T[1]:(curr_T[1] + steps + 1), curr_T[2]+diff[2]] .= 1
                curr_T = curr_T + [diff[1]+steps+1, diff[2]]
                println(curr_H)
                println(curr_T)
            else
                curr_H = curr_H + [steps, 0]
                grid[curr_T[1], curr_T[2]+diff[2]] = 1
                grid[curr_T[1]:(curr_T[1] + steps - 1), curr_T[2]+diff[2]] .= 1
                curr_T = curr_T + [diff[1]+steps-1, diff[2]]
                println(curr_H)
                println(curr_T)
            end
        elseif l[1] == "D"
            println(l)
            steps = -parse(Int, l[2])
            diff = curr_H .- curr_T
            println(diff)
            if diff[2] == 1
                curr_H = curr_H + [0, steps]
                grid[curr_T[1]+diff[1], curr_T[2]+1] = 1
                grid[curr_T[1]+diff[1], curr_T[2]+1:(curr_T[2] + steps + 1)] .= 1
                curr_T = curr_T + [diff[1], diff[2] + steps+1]
                println(curr_H)
                println(curr_T)
            else
                curr_H = curr_H + [0, steps]
                grid[curr_T[1]+diff[1], curr_T[2]+1] = 1
                grid[curr_T[1]+diff[1], curr_T[2]+1:(curr_T[2] + steps - 1)] .= 1
                curr_T = curr_T + [diff[1], diff[2] + steps-1]
                println(curr_H)
                println(curr_T)
            end
        end
    end
    return(grid)
end


grid = gen_grid(f)
println(size(grid))
visited = string_path(f, grid)
println(sum(visited[visited .== 1]))
