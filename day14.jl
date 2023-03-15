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
    ymax = maximum([maximum(rock[2] for rock in l) for l in g])
    ymax = max(500, ymax)
    ymin = minimum([minimum(rock[2] for rock in l) for l in g])
    ymin = min(0, ymin)
    xmax = maximum([maximum(rock[1] for rock in l) for l in g])
    xmax = max(500, xmax)
    xmin = minimum([minimum(rock[1] for rock in l) for l in g])
    xmin = min(0, xmin)

    grid = Array{Char}(undef, (xdim, ydim))
    grid .= '.'
    grid[start[1], start[2]] = '+'

    for l in g
        for i in 1:length(l) - 1
            rock1 = l[i]
            rock2 = l[i+1]

            if rock1[1] == rock2[1]
                x = rock1[1] - xmin + 2
                y_start = min(rock1[2], rock2[2]) - ymin + 2
                y_end = max(rock1[2], rock2[2]) - ymin + 2
                grid[x, y_start:y_end] .= '#'
            elseif rock1[2] == rock2[2]
                y = rock1[2] - ymin + 2
                x_start = min(rock1[1], rock2[1]) - xmin + 2
                x_end = max(rock1[1], rock2[1]) - xmin + 2
                grid[x_start:x_end, y] .= '#'
            end
        end
    end

    return(grid)
end

# track sand location
function falling_sand!(grid::Matrix{Char}, start::Tuple)
    status = false

    x_start = start[1]
    y_start = start[2]
    x_curr = x_start
    y_curr = y_start

    while !status

        if y_curr == size(grid)[2]
            status = true
            return(grid)
        end

        if grid[x_curr, y_curr + 1] == '.'
            grid[x_curr, y_curr] = '.'
            y_curr = y_curr + 1
#            grid[x_curr, y_curr] = 's'

        elseif grid[x_curr - 1, y_curr + 1] == '.'
            grid[x_curr, y_curr] = '.'
            y_curr = y_curr + 1
            x_curr = x_curr - 1
#            grid[x_curr, y_curr] = 's'

        elseif grid[x_curr + 1, y_curr + 1] == '.'
            grid[x_curr, y_curr] = '.'
            y_curr = y_curr + 1
            x_curr = x_curr + 1
#            grid[x_curr, y_curr] = 's'

        else
            grid[x_curr, y_curr] = 'o'
            if (x_curr, y_curr) == (x_start, y_start)
                status = true
                return(grid)
            else
                (x_curr, y_curr) = (x_start, y_start)
            end

        end

    end

end

function add_floor(g::Vector{Vector{Tuple}})
    ymax = maximum([maximum(rock[2] for rock in l) for l in g])
    ymin = minimum([minimum(rock[2] for rock in l) for l in g])
    xmax = maximum([maximum(rock[1] for rock in l) for l in g])
    xmin = minimum([minimum(rock[1] for rock in l) for l in g])

    push!(g, [(xmin-500, ymax+2), (xmax+500, ymax+2)])


    return(g)
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

xdim = xmax - xmin + 3
ydim = ymax - ymin + 3

start = (500 - xmin+2, 0 - ymin+2)

grid = build_rock(g, start)

filled_grid = falling_sand!(grid, start)

println("Part 1: ", sum(filled_grid.=='o'))


#Part 2
g = read_grid(f)
g = add_floor(g)
ymax = maximum([maximum(rock[2] for rock in l) for l in g])
ymax = max(500, ymax)
ymin = minimum([minimum(rock[2] for rock in l) for l in g])
ymin = min(0, ymin)
xmax = maximum([maximum(rock[1] for rock in l) for l in g])
xmax = max(500, xmax)
xmin = minimum([minimum(rock[1] for rock in l) for l in g])
xmin = min(0, xmin)

xdim = xmax - xmin + 3
ydim = ymax - ymin + 3

start = (500 - xmin+2, 0 - ymin+2)
grid = build_rock(g, start)
filled_grid = falling_sand!(grid, start)

println("Part 2: ", sum(filled_grid.=='o'))
