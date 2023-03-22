mutable struct Tunnel
    flow::Int
    isopen::Bool
    neighbours::Vector{String}
end

function build_network(f::Vector{String})

    network = Dict{String, Tunnel}()

    for l in f
        substr = split(l, " ")
        flow = parse(Int, strip(substr[5], ['r','a','t','e','=', ';']))
        if flow == 0
            t = Tunnel(flow, true, String[])
        else
            t = Tunnel(flow, false, String[])
        end
        connected = substr[10:end]
        for i in connected
            v = strip(i, ',')
            push!(t.neighbours, v)
        end

        network[substr[2]] = t
    end

    return(network)
end

function find_paths(network::Dict{String, Tunnel}, time::Int)
    checked = []
    unchecked = Vector[["AA"]]
    len = length(keys(network))

    t=0

    while length(unchecked) > 0 && t<=time
        current = popfirst!(unchecked)

        if length(unique(current)) == len
            push!(checked, current)
        end

        if all([network[a].isopen for a in keys(network)])
            push!(checked, current)
        end

        connected = network[current[end]]
        if connected.isopen == false && connected.flow > 0
            connected.isopen = true
        end

        for n in connected.neighbours
            new_path = deepcopy(current)
            push!(new_path, n)
            push!(unchecked, new_path)
        end

        t +=1

    end

    return(unchecked)

end

f = readlines("day16.txt")
t = readlines("test.txt")

network = build_network(f)
find_paths(network, 30)
