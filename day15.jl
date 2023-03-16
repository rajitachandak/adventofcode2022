using Distances
f = readlines("day15.txt")

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

(sensors, beacons) = locations(f)

function map_locations(sensors::Vector{Tuple}, beacons::Vector{Tuple})
    @assert (length(sensors) == length(beacons))

    xmin = min(minimum(s[1] for s in sensors), minimum(b[1] for b in beacons))
    ymin = min(minimum(s[2] for s in sensors), minimum(b[2] for b in beacons))
    xmax = max(maximum(s[1] for s in sensors), maximum(b[1] for b in beacons))
    ymax = max(maximum(s[2] for s in sensors), maximum(b[2] for b in beacons))

    xrange = collect(xmin:xmax)
    println(length(xrange))

    dis = cityblock.(sensors, beacons)

    b1 = reverse_dir.(sensors, dis)

end

map_locations(sensors, beacons)


function reverse_dir(s::Tuple{Int, Int}, d::Int)
    b2=2000000
    (s1, s2) = s

    b1= s1 + d - abs(s2-b2)

    return(b1)

end
