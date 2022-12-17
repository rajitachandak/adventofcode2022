f = readlines("day7.txt")

mutable struct Directory
    name::String
    parent::String
    files::Dict
    sub_dirs::Dict
    dir_size::Int
end

function new_dir(name, parent, file_list, sub_dirs, dir_size)
    name = Directory(name, parent, file_list, sub_dirs, dir_size)
end

#establishing file system
global system = Dict("/" => Directory("/", "", Dict(), Dict(), 0))

#initialzing directories and files
global parent = ""
global curr_dir = "/"
global files = Dict()
global dirs = ["/"]
global dir = new_dir(curr_dir, parent, Dict(), Dict(), 0)
global i = 1
while i < length(f)+1
    line = f[i]
    if startswith(line, r"\$ cd [a-z]")
        global parent = deepcopy(curr_dir)
        global curr_dir = chop(line, head=5, tail=0)
        push!(dirs, curr_dir)
        global dir = new_dir(curr_dir, parent, Dict(), Dict(), 0)
    end
    if startswith(line,  "\$ cd ..")
        global curr_dir = pop!(dirs)
    end
    if startswith(line, r"[0-9]")
        l = split(line)
        file_name = l[2]
        f_size = parse(Int, l[1])
        dir.files[file_name] = f_size
    end
    if startswith(line, r"dir")
        l = split(line)
        dir_name = l[2]
        dir.sub_dirs[dir_name] = dir_name
    end
    println(dir)
    global i +=1
end
