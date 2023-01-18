f = readlines("day12.txt")

function create_matrix(f::Vector{String})
    alphabet = collect('a':'z')
    points = collect(1:26)
    mydict = Dict(alphabet .=> points)

    n = length(f)
    m = length(f[1])

    f_mat = zeros(n, m)
    for i in 1:n
        for j in 1:m
            if f[i][j] == 'S'
                f_mat[i, j] = 0
            elseif f[i][j] == 'E'
                f_mat[i, j] = 27
            else
                f_mat[i, j] = mydict[f[i][j]]
            end
        end
    end
    return(trunc.(Int, f_mat))
end

mat = create_matrix(f)

function get_neighbours(curr_min, n, m)
    i = curr_min[1]
    j = curr_min[2]
    neighbours = []

    if i > 1
        push!(neighbours, [i-1, j])
    end

    if i < n
        push!(neighbours, [i+1, j])
    end
    if j > 1
        push!(neighbours, [i, j-1])
    end

    if j < m
        push!(neighbours, [i, j+1])
    end
    return(neighbours)
end

function dijkstra(M::Matrix{Int})
    (n, m) = size(M)

    dis = zeros(n, m)
    curr_min = []
    for i in 1:n
        for j in 1:m
            if M[i, j] == 27
                dis[i, j] = 0
                curr_min = [i, j]
            else
                dis[i, j] = Inf
            end
        end
    end

    visited = fill(false, (n, m))
    unvisited = fill(true, (n, m))

    while any(unvisited)
        curr_min = []
        for i in 1:n
            for j in 1:m
                if unvisited[i, j]
                    if isempty(curr_min)
                        curr_min = [i, j]
                    elseif dis[i, j] < dis[curr_min[1], curr_min[2]]
                        curr_min = [i, j]
                    end
                end
            end
        end

        neighbours = get_neighbours(curr_min, n, m)
        for (i,j) in neighbours
            if M[curr_min[1], curr_min[2]] -  M[i, j] == 0
                temp_val = dis[curr_min[1], curr_min[2]] + (M[curr_min[1], curr_min[2]] -  M[i, j] + 1)
            else
                temp_val = dis[curr_min[1], curr_min[2]] + (M[curr_min[1], curr_min[2]] -  M[i, j])
            end
            if temp_val < dis[i, j]
                dis[i, j] = temp_val
            end
        end
        visited[curr_min[1], curr_min[2]] = true
        unvisited[curr_min[1], curr_min[2]] = false
    end
    return(dis)
end

function min_distance(dis::Matrix, point::CartesianIndex{2})
    return(dis[point[1], point[2]])
end

dis = dijkstra(mat)
println(dis)
s = findall(a->a ==0, mat)[1]
println(s)
println("Part 1:", min_distance(dis,s))
