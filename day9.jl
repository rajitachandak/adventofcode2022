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

function get_distance(diff::Vector)
    abs_diff = broadcast(abs, diff)
    dis = sum(abs_diff)
    return(dis)
end

function move_string(diff::Vector, steps::Int, direction::String)
end

function string_path(f::Vector{String}, grid::Matrix{Int})
    #starting position
    n = trunc(Int, size(grid)[1]/2)
    curr_H = [n, n]
    curr_T = [n, n]
    grid[n, n] = 1
    # loop through all moves
    for i in 1:length(f)
        l = split(f[i], " ")
#        println(l)
        direction = l[1]
        steps = parse(Int, l[2])
        diff = curr_H - curr_T
        dis = get_distance(diff)
        if dis < 2
            if direction == "U"
                curr_H = curr_H + [0, steps]
                if diff == [0, 1] || diff == [0, 0]
                    grid[curr_T[1], curr_T[2]:(curr_T[2]+steps-1+diff[2])].=1
                    curr_T = curr_T + [0, steps-1+diff[2]]
                elseif diff == [0, -1]
                    grid[curr_T[1], curr_T[2]:(curr_T[2]+steps-2)].=1
                    curr_T = curr_T + [0, steps-2]
                else
                    grid[curr_T[1]+diff[1], curr_T[2]+1:(curr_T[2]+1+steps-2)].=1
                    curr_T = curr_T + diff + [0, 1] + [0, steps-2]
                end
            elseif direction == "D"
                curr_H = curr_H + [0, -steps]
                if diff == [0, -1] || diff == [0, 0]
                    curr_T = curr_T - [0, steps+1+diff[2]]
                    grid[curr_T[1], curr_T[2]:(curr_T[2]+steps)].=1
                elseif diff == [0, 1]
                    curr_T = curr_T - [0, steps-2]
                    grid[curr_T[1], curr_T[2]:(curr_T[2]+steps-2)].=1
                else
                    grid[curr_T[1]+diff[1], curr_T[2]+1:(curr_T[2]+1+steps-2)].=1
                    curr_T = curr_T + diff - [0, 1] + [0, steps-2]
                end
            elseif direction == "R"
                curr_H = curr_H + [steps, 0]
                if diff == [1, 0] || diff == [0, 0]
                    grid[curr_T[1]:(curr_T[1]+steps-1+diff[1]), curr_T[2]].=1
                    curr_T = curr_T + [steps-1+diff[1], 0]
                elseif diff == [-1, 0]
                    grid[curr_T[1]:(curr_T[1]+steps-2), curr_T[2]].=1
                    curr_T = curr_T + [steps-2, 0]
                else
                    grid[curr_T[1]+1:(curr_T[1]+1+steps-2), curr_T[2]+diff[2]].=1
                    curr_T = curr_T + diff + [1, 0] + [steps-2, 0]
                end
            else
                curr_H = curr_H + [-steps, 0]
                if diff == [-1, 0] || diff == [0, 0]
                    curr_T = curr_T - [steps+1+diff[1], 0]
                    grid[curr_T[1]:(curr_T[1]+steps), curr_T[2]].=1
                elseif diff == [1, 0]
                    curr_T = curr_T - [steps-2, 0]
                    grid[curr_T[1]:(curr_T[1]+steps-2), curr_T[2]].=1
                else
                    grid[curr_T[1]+1:(curr_T[1]+1+steps-2), curr_T[2]+diff[2]].=1
                    curr_T = curr_T + diff - [1, 0] + [steps-2, 0]
                end
            end

        else
            if direction == "U"
                curr_H = curr_H + [0, steps]
                if diff[2] == -1
                    if steps > 2
                        grid[curr_T[1]+diff[1], curr_T[2]+1:(curr_T[2]+steps-2)]
                        curr_T = curr_T + [diff[1], steps-2]
                    end
                else
                    grid[curr_T[1]+diff[1], curr_T[2]+1:(curr_T[2]+steps)]
                    curr_T = curr_T + [diff[1], steps]
                end
            elseif direction == "D"
                curr_H = curr_H + [0, -steps]
                if diff[2] == -1
                    grid[curr_T[1]+diff[1], curr_T[2]-steps:curr_T[2]-1]
                    curr_T = curr_T + [diff[1], -steps]
                else
                    if steps > 2
                        grid[curr_T[1]+diff[1], curr_T[2]+1:(curr_T[2]+steps-3)]
                        curr_T = curr_T + [diff[1], -(steps-2)]
                    else
                        curr_T = curr_T
                    end
                end
            elseif direction == "R"
                curr_H = curr_H + [steps, 0]
                    if diff[1] == -1
                        if steps > 2
                            grid[curr_T[1]+1:(curr_T[1]+steps-2), curr_T[2]+diff[2]]
                            curr_T = curr_T + [steps-2, diff[2]]
                        end
                    else
                        grid[curr_T[1]+1:(curr_T[1]+steps), curr_T[2]+diff[2]]
                        curr_T = curr_T + [steps, diff[2]]
                    end
            else
                curr_H = curr_H + [-steps, 0]
                if diff[2] == -1
                    grid[curr_T[1]-steps:curr_T[1]-1, curr_T[2]+diff[2]]
                    curr_T = curr_T + [-steps, diff[2]]
                else
                    if steps > 2
                        grid[curr_T[1]+1:(curr_T[1]+steps-3), curr_T[2]+diff[2]]
                        curr_T = curr_T + [-(steps-2), diff[2]]
                    end
                end
            end
        end
#        println(curr_H)
#        println(curr_T)
#        println(sum(grid[grid .== 1]))
    end
    return(grid)
end


grid = gen_grid(f)
visited = string_path(f, grid)
println(sum(visited[visited .== 1]))

# 5532 too low
