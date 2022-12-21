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
    grid[n, n] = 1
    # loop through all moves
    for i in 1:12
        l = split(f[i])
        if l[1] == "U"
            println(l)
            steps = parse(Int, l[2])
            diff = curr_H .- curr_T
            println(diff)
            curr_H = curr_H + [0, steps]
            grid[curr_T[1]+diff[1], curr_T[2]+1] = 1
            grid[curr_T[1]+diff[1], curr_T[2]+1:(curr_T[2] + steps - 1)] .= 1
            curr_T = curr_T + [diff[1], diff[2] + steps-1]
            println(curr_H)
            println(curr_T)

#            if pos_diff[1] != 0
#                curr_T = curr_T + [pos_diff[1], steps]
#                grid[curr_T[1]+pos_diff[1], curr_T[2]+1] = 1
#                grid[curr_T[1]+1, curr_T[2]+1:(curr_T[2] + steps - 2)] .= 1
#            elseif pos_diff[2] !=0
#            end

#            if curr_H + [0, 1] == curr_T
#                steps = parse(Int, l[2]) - 2
#                curr_H = curr_H .+ [0, steps+2]
#                grid[curr_T[1], curr_T[2]:(curr_T[2] + steps)] .= 1
#                curr_T = curr_T .+ [0, steps]
#            elseif curr_T + [1, 1] == curr_H
#                steps = parse(Int, l[2]) - 1
#                curr_H = curr_H .+ [0, steps+1]
#                grid[curr_T[1]+1, curr_T[2]+1] = 1
#                grid[curr_T[1]+1, curr_T[2]:(curr_T[2] + steps-1)] .= 1
#                curr_T = curr_T .+ [1, steps+1]
#            elseif  curr_T + [-1, 1] == curr_H
#                steps = parse(Int, l[2]) - 1
#                curr_H = curr_H .+ [0, steps+1]
#                grid[curr_T[1]-1, curr_T[2]+1] = 1
#                grid[curr_T[1]-1, curr_T[2]:(curr_T[2] + steps-1)] .= 1
#                curr_T = curr_T .+ [-1, steps+1]
#            elseif curr_H + [1, 0] == curr_T
#                steps = parse(Int, l[2]) - 1
#                curr_H = curr_H .+ [0, steps+1]
#                grid[curr_T[1]-1, curr_T[2]+1] = 1
#                grid[curr_T[1]-1, curr_T[2]+1:(curr_T[2] + steps)] .= 1
#                curr_T = curr_T .+ [-1, steps]
#            else
#                steps = parse(Int, l[2]) - 1
#                curr_H = curr_H .+ [0, steps+1]
#                grid[curr_T[1], curr_T[2]:(curr_T[2] + steps)] .= 1
#                curr_T = curr_T .+ [0, steps]
#            end
#        elseif l[1] == "R"
#            pos_diff = curr_H .- curr_T
#            println(pos_diff)
#            if curr_H + [1, 0] == curr_T
#                steps = parse(Int, l[2]) - 2
#                curr_H = curr_H .+ [steps+2, 0]
#                grid[curr_T[1]:(curr_T[1] + steps), curr_T[2]] .= 1
#                curr_T = curr_T .+ [steps, 0]
#            elseif curr_H + [1, 1] == curr_T
#                #TODO HERE
#                steps = parse(Int, l[2]) - 2
#                curr_H = curr_H .+ [0, steps+2]
#                grid[curr_T[1], curr_T[2]:(curr_T[2] + steps)] .= 1
#                curr_T = curr_T .+ [0, steps]
#            else
#                steps = parse(Int, l[2]) - 1
#                curr_H = curr_H .+ [steps+1, 0]
#                grid[curr_T[1]:(curr_T[1] + steps), curr_T[2]] .= 1
#                curr_T = curr_T .+ [steps, 0]
#            end
#        elseif l[1] == "L"
#            pos_diff = curr_H .- curr_T
#            println(pos_diff)
#            if curr_H - [0, 1] == curr_T
#                steps = parse(Int, l[2]) - 2
#                curr_H = curr_H .- [steps+2, 0]
#                curr_T = curr_T .- [steps, 0]
#                grid[curr_T[1]:(curr_T[1] + steps), curr_T[2]] .= 1
#            elseif curr_H - [1, 1] == curr_T
#                #TODO HERE
#                steps = parse(Int, l[2]) - 2
#                curr_H = curr_H .+ [0, steps+2]
#                grid[curr_T[1], curr_T[2]:(curr_T[2] + steps)] .= 1
#                curr_T = curr_T .+ [0, steps]
#            else
#                steps = parse(Int, l[2]) - 1
#                curr_H = curr_H .- [steps+1, 0]
#                curr_T = curr_T .- [steps, 0]
#                grid[curr_T[1]:(curr_T[1] + steps), curr_T[2]] .= 1
#            end
#        elseif l[1] == "D"
#            pos_diff = curr_H .- curr_T
#            println(pos_diff)
#            if curr_H - [0, 1] == curr_T
#                steps = parse(Int, l[2]) - 2
#                curr_H = curr_H .- [0, steps+2]
#                curr_T = curr_T .- [0, steps]
#                grid[curr_T[1], curr_T[2]:(curr_T[2] + steps)] .= 1
#            elseif curr_H - [1, 1] == curr_T || curr_H - [1, 1] == curr_T
#                #TODO HERE
#                steps = parse(Int, l[2]) - 2
#                curr_H = curr_H .+ [0, steps+2]
#                grid[curr_T[1], curr_T[2]:(curr_T[2] + steps)] .= 1
#                curr_T = curr_T .+ [0, steps]
#            else
#                steps = parse(Int, l[2]) - 1
#                curr_H = curr_H .- [0, steps+1]
#                curr_T = curr_T .- [0, steps]
#                grid[curr_T[1], curr_T[2]:(curr_T[2] + steps)] .= 1
#            end
        end
    end
    return(grid)
end


grid = gen_grid(f)
println(size(grid))
visited = string_path(f, grid)
println(sum(visited[visited .== 1]))
