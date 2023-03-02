#convert input to vector of tuples
function read_grid(f::Vector{String})
    grid_points = Vector{Tuple}[]
    list = Tuple[]
    f = split.(f, "->")
    for l in f
        for loc in l
            coord = [parse.(Int, x) for x in split.(loc, ',')]
            coord = Tuple(x for x in coord)
            push!(list, coord)
        end
        push!(grid_points, list)
        list = Tuple[]
    end
    return(grid_points)
end

#expand all rock points
function build_rock(g::Vector)
end

# track sand location
function falling_sand(g::Vector)
    s = (500, 0)
    #use findmin?
end


f = readlines("day14.txt")

g = read_grid(f)
