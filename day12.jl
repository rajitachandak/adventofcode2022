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

function dijkstra(M::Matrix{Int}, end_node)
    (n, m) = size(M)

    dis = zeros(n, m)
    curr_node = []
    for i in 1:n
        for j in 1:m
            if M[i, j] == 0
                dis[i, j] = 0
                curr_node = (i, j)
            else
                dis[i, j] = Inf
            end
        end
    end

    visited = []
    unvisited = Tuple.(findall(a-> isa(a, Number), dis))

    while dis[end_node] == Inf
        neighbours = get_neighbours(curr_node, n, m)
        for node in neighbours
            i = node[1]
            j = node[2]
            if abs(M[i, j] - M[curr_node...])<=1
                min_dis = min(dis[i, j], dis[curr_node[1], curr_node[2]]+1)
                dis[i, j] = min_dis
            end
        end
        push!(visited, curr_node)
        deleteat!(unvisited, findall(x->x ==curr_node, unvisited))
        curr_node = unvisited[findmin([dis[i...] for i in unvisited])[2]]
    end

    return(dis)
end


#display(mat)
s = findall(a->a ==27, mat)[1]
dis = dijkstra(mat, s)
#println(dis)
println(s)
dis[s]
