f = readlines("day7.txt")

#find all dir strings
function dir_loc(s)
    dir_list = findall(x -> startswith(x, "dir"), s)
    return dir_list
end
#collect all directory names
function dir_names(s)
    dirs = [chop(x, head=4, tail=0) for x in s]
    return (dirs)
end

locations = dir_loc(f)
all_dirs = f[locations]
dir_list = dir_names(all_dirs)
println(dir_list)

# dictionary of dirs


#
