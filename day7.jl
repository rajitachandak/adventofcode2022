f = readlines("day7.txt")

mutable struct Directory
    name::String
    parent::String
    dir_size::Int
end

mutable struct File
    name::String
    dir::Directory
    file_size::Int
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
