f = readlines("day7.txt")

#find all dir strings
function object_loc(s, word)
    dir_list = findall(x -> startswith(x, word), s)
    return dir_list
end
#collect all directory names
function dir_names(s, l)
    dirs = [chop(x, head=l, tail=0) for x in s]
    return (dirs)
end

cd_loc = object_loc(f, r"\$ cd [a-z]")
dir_loc = dir_names(f[cd_loc], 5)
global mydict = Dict()
for i in 1:length(cd_loc)-1
    mydict[dir_loc[i]] = f[cd_loc[i]+2:cd_loc[i+1]-1]
    dir_list = object_loc(mydict[dir_loc[i]], "dir")
    println(dir_loc[i])
    println(dir_list)
    if isempty(dir_list)
        println("not nested")
    else
    end
end
#println(mydict)
# dictionary of dirs


#
