using Distances
f = readlines("day15.txt")
t = readlines("test.txt")

function locations(f::Vector{String})
    sensors = Tuple[]
    beacons = Tuple[]
    for l in f
        s = split(l, ' ')
        sx = parse(Int, strip(s[3], ['x', '=', ',']))
        sy = parse(Int, strip(s[4], ['y', '=', ':']))
        push!(sensors, (sx, sy))
        bx = parse(Int, strip(s[9], ['x', '=', ',']))
        by = parse(Int, strip(s[10], ['y', '=', ':']))
        push!(beacons, (bx, by))
    end

    return(sensors, beacons)

end


function map_locations(sensors::Vector{Tuple}, beacons::Vector{Tuple})
    @assert (length(sensors) == length(beacons))
    b2=2000000
    #b2=10

    xmin = min(minimum(s[1] for s in sensors), minimum(b[1] for b in beacons))
    ymin = min(minimum(s[2] for s in sensors), minimum(b[2] for b in beacons))
    xmax = max(maximum(s[1] for s in sensors), maximum(b[1] for b in beacons))
    ymax = max(maximum(s[2] for s in sensors), maximum(b[2] for b in beacons))

    xrange = collect(xmin:xmax)

    dis = cityblock.(sensors, beacons)

    xlist = []
    for i in 1:length(sensors)
        s = sensors[i]
        d = cityblock(s, [s[1], b2])
        if d == dis[i]
            push!(xlist, [s[1]])
        elseif d < dis[i]
            dstar = dis[i] - d
            push!(xlist, (s[1]-dstar):(s[1]+dstar))
        end
    end
    return(xlist)

end

function covered_blocks(ranges::Vector)
    covered = union(ranges[1])
    for i in 2:length(ranges)
        covered = union(covered, ranges[i])
    end

    return(maximum(covered) - minimum(covered))
end

(sensors, beacons) = locations(f)
ranges = map_locations(sensors, beacons)
println("Part 1:", covered_blocks(ranges))
