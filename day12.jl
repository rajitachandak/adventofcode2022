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
#display(mat)
#println()

function next_step(curr_row::Int, curr_col::Int, M::Matrix)
    curr_val = M[curr_row, curr_col]

    next_step = []
    if curr_row>1 && curr_col>1
        if abs(M[curr_row-1, curr_col] - curr_val)<= 1
            push!(next_step, [curr_row-1, curr_col])
        end
        if abs(M[curr_row+1, curr_col] - curr_val) <=1
            push!(next_step, [curr_row+1, curr_col])
        end
        if abs(M[curr_row, curr_col+1] - curr_val) <=1
            push!(next_step, [curr_row, curr_col+1])
        end
        if abs(M[curr_row, curr_col-1] - curr_val) <=1
            push!(next_step, [curr_row, curr_col-1])
        end
    else
        if abs(M[curr_row+1, curr_col] - curr_val) <=1
            push!(next_step, [curr_row+1, curr_col])
        end
        if abs(M[curr_row, curr_col+1] - curr_val) <=1
            push!(next_step, [curr_row, curr_col+1])
        end
    end
    return(next_step)
end
println(next_step(2, 2, mat))

function map_path(M::Matrix{Int}, s::Int, e::Int)
    (n, m) = size(M)

    end_point = findall(x->x==e, M)
    end_col = end_point[1][2]
    end_row = end_point[1][1]

    start_point = findall(x->x==s, M)
    start_col = start_point[1][2]
    start_row = start_point[1][1]

    steps = 0

end

println(map_path(mat, 0, 27))
