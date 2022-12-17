f = readlines("day8.txt")
n = length(f)
m = length(f[1])

global n_vis = n + 3*(n-1)
println(n_vis)

f_mat = Matrix{Int}(undef, (n, m))
for i in 1:length(f)
    for j in 1:length(f)
        f_mat[i, j] = parse(Int,f[i][j])
    end
end


function running_max(mat)
    (n, m) = size(mat)
    running_max = Matrix{Int}(undef, (n, m))

    for i in 1:n
        for j in 1:m
            if i == 1
                running_max[i,j] = mat[i,j]
            else
                running_max[i,j] = max(running_max[i-1,j], mat[i,j])
            end
        end
    end

    return running_max
end
println(get_running_max(f_mat))
