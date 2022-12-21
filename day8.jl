f = readlines("day8.txt")
n = length(f)
m = length(f[1])
println(n)
println(m)

f_mat = Matrix{Int}(undef, (n, m))
for i in 1:length(f)
    for j in 1:length(f)
        f_mat[i, j] = parse(Int,f[i][j])
    end
end


function current_max(mat)
    (n, m) = size(mat)
    current_max = Matrix{Int}(undef, (n, m))

    for i in 1:n
        for j in 1:m
            if i == 1
                current_max[i, j] = mat[i, j]
            else
                current_max[i, j] = max(current_max[i-1, j], mat[i, j])
            end
        end
    end

    return current_max
end

function visible(mat)
    (n, m) = size(mat)
    vis = falses(n, m)
    max_mat = current_max(mat)

    for i in 1:n
        for j in 1:m
            if i ==1
                vis[i, j] = true
            elseif mat[i, j] > max_mat[i-1, j]
                vis[i, j] = true
            end
        end
    end

    return(vis)
end

top_vis = visible(f_mat)
bottom_vis = reverse(visible(reverse(f_mat, dims = 1)), dims = 1)
right_vis = reverse(visible(reverse(f_mat', dims = 1)), dims = 1)'
left_vis = reverse(visible(reverse(f_mat', dims = 2)), dims = 2)'

total_vis = top_vis .|| bottom_vis .|| right_vis .|| left_vis
println("Part 1: ", sum(total_vis))


function scenic_score(mat)

end
