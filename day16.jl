#TODO: change struct type
mutable struct Tunnel
    flow::Int
    isopen::Bool
    neighbours::Vector{String}
end

#TODO: Change input parsing
function build_network(f::Vector{String})

    network = Dict{String, Tunnel}()
    n = length(f)

    ind = Dict{String, Int}()

    grid = Matrix{Int}(undef, n, n)
    grid .= 0

    valves = Vector{Int}(undef, n)

    for i in 1:n
        l = f[i]
        substr = split(l, " ")
        ind[substr[2]] = i
    end

    for i in 1:n
        l = f[i]
        substr = split(l, " ")
        flow = parse(Int, strip(substr[5], ['r','a','t','e','=', ';']))
        valves[i] = flow
        t = Tunnel(flow, false, String[])
        connected = substr[10:end]
        ind[substr[2]] = i
        for j in connected
            v = strip(j, ',')
            push!(t.neighbours, v)
            grid[i, ind[v]] = 1
        end

        network[substr[2]] = t
    end


    return(valves, grid, network, ind["AA"])
end

function shortest_path(grid::Matrix, start::Int)

    n = size(grid)[1]
    visited = fill(false, n)
    len = fill(Inf, n)
    len[start] = 0
    done = false

    while !done
        min_unvisit = minimum([len[i] for i in 1:n if !visited[i]])
        curr = findfirst(l -> (len[l]==min_unvisit &&  !visited[l]), 1:n)

        for node in 1:n
            if node != curr
                dis = grid[curr, node]
                if dis > 0
                    len[node] = min(len[curr]+dis, len[node])
                    end
            end
        end

        visited[curr] = true
        done = all(visited)
    end

    return(len)

end

function all_paths(pipes::Vector, grid::Matrix)

    n = length(pipes)
    println(n)
    paths = Matrix{Int}(undef, n, n)

    for i in 1:n
        ls = shortest_path(grid, Int(i))
        #println(shortest_path(grid, Int(i)))
        for j in 1:n
            if i != j
                paths[i, j] = Int(ls[j])
            else
                paths[i, j] = 0
            end
        end
    end

    return(paths)

end

function remove_zeros(pipes::Vector, grid::Matrix)

    n = length(pipes)
    non_zero_ind = [i for i in 1:n if pipes[i] != 0 || i == 1]
    nz = length(non_zero_ind)
    new_pipes = Vector{Int}(undef, nz)
    new_grid = Matrix{Int}(undef, nz, nz)

    for i in 1:nz
        new_pipes[i] = pipes[non_zero_ind[i]]
    end

    for i in 1:nz
        for j in 1:nz
            new_grid[i, j] = grid[non_zero_ind[i], non_zero_ind[j]]
        end
    end

    return (new_pipes, new_grid)

end

function increment(state, pipes::Vector, grid::Matrix, network::Dict, time_lim::Int)
    n = length(pipes)

end

function pressure(pipes::Vector, grid::Matrix, network::Dict, time_lim::Int)

    n = length(pipes)
    checked = []
    p = 0


end

#f = readlines("day16.txt")
t = readlines("test.txt")

pipes, grid, network, AA = build_network(t)
grid = all_paths(grid)
(pipes, grid) = remove_zeros(pipes, grid)
#p = find_paths(network, 30)
