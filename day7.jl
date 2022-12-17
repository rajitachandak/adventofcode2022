f = readlines("day7.txt")

mutable struct Directory
    name::String
    parent::String
    files::Dict
    dir_size::Int
end

mutable struct File
    name::String
    parent_dir::String
    file_size::Int
end

function new_file(name, parent_dir, file_size)
    name = File(name, parent_dir, file_size)
end

function new_dir(name, parent, file_list, dir_size)
    name = Directory(name, parent, file_list, dir_size)
end

#establishing file system
global system = Dict("/" => Directory("/", "", Dict(), 0))
global files = Dict()
global dirs = Dict()

#initialzing directories and files
global parent = "/"
global i = 1
while i < length(f)+1
    line = f[i]
    if startswith(line, r"\$ cd [a-z]")
        global parent = chop(line, head=5, tail=0)
    end
    if startswith(line, r"[0-9]")
        l = split(line)
        file_name = l[2]
        global files[file_name] = new_file(l[2], parent, parse(Int, l[1]))
    end
    if startswith(line, r"dir")
        l = split(line)
        dir_name = l[2]
        global dirs[dir_name] = new_dir(l[2], parent, Dict(), 0)
    end
    global i +=1
end
