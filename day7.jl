f = readlines("day7.txt")

dir_list =["/"]
for l in f
    if startswith(l, r"\$ cd [a-z]")
        push!(dir_list, chop(l, head=5, tail=0))
    end
end

#initialzing directories and files
global sizes = Dict("/" => 0)
dirs = ["/"]
for i in 1:length(f)
    line = f[i]
    if startswith(line, r"\$ cd [a-z]")
        global curr_dir = chop(line, head=5, tail=0)
        push!(dirs, curr_dir)
        global sizes[curr_dir] = 0
    end

    if startswith(line, r"[0-9]")
        l = split(line)
        file_name = l[2]
        f_size = parse(Int, l[1])
        for r in dirs
            sizes[r] += f_size
        end
    end

    if startswith(line,  "\$ cd ..")
        global curr_dir = pop!(dirs)
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
println(total_size(100000, sizes))
