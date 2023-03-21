using Distances

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

function map(sensors::Vector{Tuple}, beacons::Vector{Tuple}, b2::Int)
    @assert (length(sensors) == length(beacons))

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

function neighbours(sensor::Tuple, d::Int, lim::Int)
    (s1, s2) = sensor
    neighbours = []

    if 0<=s2+d+1<=lim
        push!(neighbours, (s1, s2+d+1))
    end
    if 0<=s2-d-1<=lim
        push!(neighbours, (s1, s2-d-1))
    end
    if 0<=s1+d+1<=lim
        push!(neighbours, (s1+d+1, s2))
    end
    if 0<=s1-d-1<=lim
        push!(neighbours, (s1-d-1, s2))
    end

    for i in 1:d
        if 0<=s1+i<=lim && 0<=s2+d+1-i<=lim
            push!(neighbours, (s1+i, s2+d+1-i))
        end
        if 0<=s1-i<=lim && 0<=s2+d+1-i<=lim
            push!(neighbours, (s1-i, s2+d+1-i))
        end
        if 0<=s1+i<=lim && 0<=s2-d-1+i<=lim
            push!(neighbours, (s1+i, s2-d-1+i))
        end
        if 0<=s1-i<=lim && 0<=s2-d-1+i<=lim
        push!(neighbours, (s1-i, s2-d-1+i))
        end
    end

    return(neighbours)

end

function in_range(point::Tuple, sensor::Tuple, d::Int)

    return(cityblock(point, sensor) <= d)

end

function all_neighbours(sensors::Vector{Tuple}, dis::Vector{Int}, lim::Int)
    points = []

    for i in 1:length(sensors)
        s = sensors[i]
        d = dis[i]
        append!(points, neighbours(s, d, lim))
    end

    return(unique(points))
end

function find_beacon(sensors::Vector{Tuple}, dis::Vector{Int}, lim::Int)
    points = all_neighbours(sensors, dis, lim)
    uncovered = []

    for p in points
        covered = false
        for i in 1:length(sensors)
            if in_range(p, sensors[i], dis[i])
                covered = true
            end
        end
        if covered == false
            push!(uncovered, p)
        end
    end

    return(uncovered)

end

function tuning_frequency(point)
    (x, y) = point[]
    return(4000000*x + y)
end

f = readlines("day15.txt")

#Part 1
(sensors, beacons) = locations(f)
b2=2000000
ranges = map(sensors, beacons, b2)
println("Part 1: ", covered_blocks(ranges))


#Part 2
lmax = 4000000
d = cityblock.(sensors, beacons)
b_loc = find_beacon(sensors, d, lmax)
println("Part 2: ", tuning_frequency(b_loc))
