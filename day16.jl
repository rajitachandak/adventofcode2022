mutable struct Status
    isopen::Vector{Bool}
    time::Int
    pressure::Int
    curr_pos::Int
end

mutable struct Route
    path::Vector{Int}
    pressure::Int
end

function build_network(f::Vector{String})

    n = length(f)

    ind = Dict{String, Int}()

    grid = Matrix{Int}(undef, n, n)
    grid .= 0

    valves = Vector{Int}(undef, n)
    isopen = Vector{Bool}(undef, n)
    isopen .= false

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
        connected = substr[10:end]
        ind[substr[2]] = i
        for j in connected
            v = strip(j, ',')
            grid[i, ind[v]] = 1
        end

    end

    status = Status(isopen, 0, 0, ind["AA"])

    return(valves, grid, status, ind["AA"])
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
    paths = Matrix{Int}(undef, n, n)

    for i in 1:n
        ls = shortest_path(grid, Int(i))
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

function remove_zeros(pipes::Vector, grid::Matrix, status::Status)

    n = length(pipes)
    non_zero_ind = [i for i in 1:n if pipes[i] != 0 || i == status.curr_pos]
    nz = length(non_zero_ind)
    new_pipes = Vector{Int}(undef, nz)
    new_grid = Matrix{Int}(undef, nz, nz)
    new_isopen = Vector{Int}(undef, nz)
    new_curr_pos = status.curr_pos

    for i in 1:nz
        new_pipes[i] = pipes[non_zero_ind[i]]
        new_isopen[i] = status.isopen[non_zero_ind[i]]
        if non_zero_ind[i] == status.curr_pos
            new_curr_pos = i
        end
    end

    for i in 1:nz
        for j in 1:nz
            new_grid[i, j] = grid[non_zero_ind[i], non_zero_ind[j]]
        end
    end

    new_status = Status(new_isopen, status.time, status.pressure, new_curr_pos)
    return (new_pipes, new_grid, new_status)

end

function increment(loc, pipes::Vector, grid::Matrix, status::Status, time_lim::Int)
    n = length(pipes)

    if loc == status.curr_pos
        time = status.time + 1
    else
        l = grid[status.curr_pos, loc]
        time = status.time + l + 1
    end

    pressure = status.pressure + pipes[loc]*max(time_lim-time, 0)
    open = copy(status.isopen)
    open[loc] = true

    new_status = Status(open, time, pressure, loc)

end

function pressure(pipes::Vector, grid::Matrix, status::Status, time_lim::Int)

    n = length(pipes)
    tocheck = [status]
    p = 0
    while length(tocheck)>0
        s = pop!(tocheck)
        for i in 1:n
            if !s.isopen[i]
                s_update = increment(i, pipes, grid, s, time_lim)
                if s_update.time <= time_lim
                    push!(tocheck, s_update)
                    if s_update.pressure > p
                        p = s_update.pressure
                    end
                end
            end
        end
    end

    return(p)
end

function get_routes(pipes::Vector, grid::Matrix, status::Status, time_lim::Int, min_pressure::Int)

    n = length(pipes)
    all_routes = Route[]
    route = Route([status.curr_pos], status.pressure)
    tocheck = Tuple{Status, Route}[(status, route)]

    while length(tocheck)>0
        (s, r) = pop!(tocheck)
        for i in 1:n
            if !s.isopen[i]
                s_update = increment(i, pipes, grid, s, time_lim)
                if s_update.time <= time_lim
                    r_update = Route([r.path; i], s_update.pressure)
                    push!(tocheck, (s_update, r_update))
                end
                if s_update.pressure > min_pressure
                    r_update = Route([r.path; i], s_update.pressure)
                    push!(all_routes, r_update)
                end
            end
        end
    end

    return(all_routes)
end

function joint_pressure(all_routes::Vector{Route})

    n = length(all_routes)
    p = 0

    for i in 1:n
        for j in 1:n
            if i>j
                r1 = all_routes[i]
                r2 = all_routes[j]
                total_p = r1.pressure + r2.pressure
                if length(intersect(r1.path[2:end], r2.path[2:end])) == 0
                    if total_p > p
                        p = total_p
                    end
                end
            end
        end
    end

    return(p)

end

f = readlines("day16.txt")
t = readlines("test.txt")

pipes, grid, status, AA = build_network(t)
grid = all_paths(pipes, grid)
(pipes, grid, status) = remove_zeros(pipes, grid, status)

p = pressure(pipes, grid, status, 30)
println("Part 1: ", p)

all_routes = get_routes(pipes, grid, status, 26, 1000)
part2 = joint_pressure(all_routes)
println("Part 2: ", part2)