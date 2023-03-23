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

function cycling_path(path::Vector{String})
    n = length(path)
    l = trunc(Int, floor(n/2))

    for i in 2:l
        for j in 0:(n-2*i)
            if path[1+j:i+j] == path[i+j+1:2*i+j]
                return true
            end
        end
    end

    return false

end

function find_paths(network::Dict{String, Tunnel}, time::Int)
    checked = []
    unchecked = Vector[["AA"]]

    t = 0
    flow = 0

    while length(unchecked) > 0
        current = popfirst!(unchecked)

        connected = network[current[end]]

        for n in connected.neighbours
            new_path = deepcopy(current)
            push!(new_path, n)
            #println(new_path)
            if !cycling_path(new_path)
                pushfirst!(unchecked, new_path)
            else
            #    println("cycling path")
                continue
            end
        end

        if length(unique(current)) == length(keys(network)) || length(current)==30
            push!(checked, current)
            #println(current)
            #println("path completed")
        end

    end

    return(unchecked)

end

#f = readlines("day16.txt")
t = readlines("test.txt")

network = build_network(t)
#find_paths(network, 30)
#path = ["AA", "BB", "II", "JJ", "FF",  "II", "JJ", "II", "KK", "LL", "II", "JJ", "KK"#]
#cycling_path(path)
