f = readlines("day12.txt")

function create_matrix(f::Vector{String})
    alphabet = collect('a':'z')
    points = collect(26:-1:1)
    mydict = Dict(alphabet .=> points)

    n = length(f)
    m = length(f[1])

    f_mat = zeros(n, m)
    for i in 1:n
        for j in 1:m
            if f[i][j] == 'S'
                f_mat[i, j] = 27
            elseif f[i][j] == 'E'
                f_mat[i, j] = 0
            else
                f_mat[i, j] = mydict[f[i][j]]
            end
        end
    end
    return(trunc.(Int, f_mat))
end

mat = create_matrix(f)

function update_dis!(curr_min, M::Matrix)
    min_val = curr_min[1]
    min_row = curr_min[2][1]
    min_col = curr_min[2][1]

    if abs(M[curr_row-1, curr_col] - curr_val)<= 1
    end
    if abs(M[curr_row+1, curr_col] - curr_val) <=1
    end
    if abs(M[curr_row, curr_col+1] - curr_val) <=1
    end
    if abs(M[curr_row, curr_col-1] - curr_val) <=1
    end
end

function map_dis(M::Matrix{Int}, s::Int, e::Int)
    (n, m) = size(M)

    steps = 0
    dis = zeros(n, m)
    for i in 1:n
        for j in 1:m
            if M[i, j] == 0
                dis[i, j] = 0
            else
                dis[i, j] = Inf
            end
        end
    end

    min_v = findmin(dis)
    dis = update_dis!(min_v, dis)

    return()
end

println(map_dis(mat, 0, 27))
