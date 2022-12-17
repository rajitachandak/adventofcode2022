f = readlines("day7.txt")

mutable struct Directory
    name::String
    parent::String
    files::Dict
    dir_size::Int
end

mutable struct File
    name::String
    dir::Directory
    file_size::Int
end

function files(name, parent_dir, file_size)
    name = File(name, parent_dir, file_size)
end

function dirs(name, parent, file_list, dir_size)
    name = Directory(name, parent, file_list, dir_size)
end

system = Directory("/", "", 0)
println(system)

for i in 1:length(f)
    line = f[i]
    if startswith(line, r"\$ cd [a-z]")
#        println(chop(line, head=5, tail=0))
#        i = Directory(chop(line, head=5, tail=0), i-1, 0)
    end
end
