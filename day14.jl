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
function build_rock(g::Vector{Vector{Tuple}}, start::Tuple)

    grid = Array{Char}(undef, (xdim, ydim))
    grid .= '.'
    grid[start[1], start[2]] = '+'

    for l in g
        for i in 1:length(l) - 1
            rock1 = l[i]
            rock2 = l[i+1]

            if rock1[1] == rock2[1]
                x = rock1[1] - xmin + 1
                y_start = min(rock1[2], rock2[2]) - ymin + 1
                y_end = max(rock1[2], rock2[2]) - ymax + 1
                grid[x, y_start:y_end] .= '#'
            elseif rock1[2] == rock2[2]
                y = rock1[2] - ymin + 1
                x_start = min(rock1[1], rock2[1]) - xmin + 1
                x_end = max(rock1[1], rock2[1]) - xmax + 1
                grid[x_start:x_end, y] .= '#'
            end
        end
    end

    return(grid)
end

# track sand location
function falling_sand(grid::Matrix{Char}, start::Tuple)
    #use findmin?
end


f = readlines("day14.txt")

g = read_grid(f)

ymax = maximum([maximum(rock[2] for rock in l) for l in g])
ymax = max(500, ymax)
ymin = minimum([minimum(rock[2] for rock in l) for l in g])
ymin = min(0, ymin)
xmax = maximum([maximum(rock[1] for rock in l) for l in g])
xmax = max(500, xmax)
xmin = minimum([minimum(rock[1] for rock in l) for l in g])
xmin = min(0, xmin)

xdim = xmax - xmin + 2
ydim = ymax - ymin + 2

start = (500 - xmin+1, 0 - ymin+1)

grid = build_rock(g, start)
