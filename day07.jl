f = readlines("day7.txt")

dir_list =["/"]
for l in f
    if startswith(l, r"\$ cd [a-z]")
        push!(dir_list, chop(l, head=5, tail=0))
    end
end

#initialzing directories and files
global sizes = Dict(collect(1:length(dir_list)) .=> 0)
global idx = [1]
for i in 1:length(f)
    line = f[i]
    if startswith(line, r"\$ cd [a-z]")
        push!(idx, i)
        global sizes[i] = 0
    end

    if startswith(line, r"[0-9]")
        l = split(line)
        file_name = l[2]
        f_size = parse(Int, l[1])
        for j in idx
            sizes[j] += f_size
        end
    end

    if startswith(line,  "\$ cd ..")
        pop!(idx)
    end
end


function total_size(threshold, dirs)
    sum = 0
    for i in dirs
        if i.second<=threshold
            sum+=i.second
        end
    end
    return (sum)
end

part1 = total_size(100000, sizes)
println("Part 1: ", part1)


#Part 2
#free memory
m = 70000000 - sum(sizes[1])

function smallest_dir(threshold, dirs)
    dir_size = []
    for i in dirs
        if i.second>=threshold
            push!(dir_size,  i.second)
        end
    end
    return(minimum(dir_size))
end

println("Part 2: ", smallest_dir(30000000-m, sizes))
