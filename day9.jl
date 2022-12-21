f = readlines("day9.txt")
function gen_grid(f::Vector{String})
    n_u = 10
    n_d = 10
    n_r = 10
    n_l = 10
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
    grid = zeros(n,n)

    return(grid)
end

grid = gen_grid(f)

function string_path(f::Vector{String}, grid)
    #starting position
    curr_H = [10, 10]
    curr_T = [10, 10]
    grid[10, 10] = 1
    # loop through all moves
    for i in 1:length(f)
        l = split(f[i])
        if l[1] == "U"
            # if head moves up
            # move tail up
            # mark grid points visited
            n = parse(Int, l[2])
            grid[curr_T[1], curr_T[2]:(curr_T[2] + n)] .= 1
            curr_T = curr_T .+ [0, n]
        elseif l[1] == "R"
            n = parse(Int, l[2])
            grid[curr_T[1]:(curr_T[1] + n), curr_T[2]] .= 1
            curr_T = curr_T .+ [n, 0]
        elseif l[1] == "L"
            n = parse(Int, l[2])
            println(curr_T)
            println(n)
            curr_T = curr_T .- [n, 0]
            println(curr_T)
            grid[curr_T[1]:(curr_T[1] + n), curr_T[2]] .= 1
        elseif l[1] == "D"
            n = parse(Int, l[2])
            curr_T = curr_T .- [0, n]
            grid[curr_T[1], curr_T[2]:(curr_T[2] + n)] .= 1
        end
    end

    return(grid)
end
visited = string_path(f, grid)
printlm(sum(visited))
