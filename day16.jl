mutable struct Tunnel
    flow::Int
    isopen::Bool
    neighbours::Vector{String}
end

function build_network(f::Vector{String})

    network = Dict{String, Tunnel}()
    n = length(f)

    ind = Dict{String, Int}()

    grid = Matrix{Int}(undef, n, n)
    grid .= 0

    for i in 1:n
        l = f[i]
        substr = split(l, " ")
        ind[substr[2]] = i
    end

    for i in 1:n
        l = f[i]
        substr = split(l, " ")
        flow = parse(Int, strip(substr[5], ['r','a','t','e','=', ';']))
        t = Tunnel(flow, false, String[])
        connected = substr[10:end]
        ind[substr[2]] = i
        for j in connected
            v = strip(j, ',')
            push!(t.neighbours, v)
            grid[i, ind[v]] = 1
        end

        network[substr[2]] = t
    end


    return(grid, network)
end

function find_paths(network::Dict{String, Tunnel}, time::Int)
    checked = []
    unchecked = Vector[["AA"]]

    t = 0

    while length(unchecked) > 0 && t < 30
        println(length(unchecked))
        display(unchecked)

        current = popfirst!(unchecked)

        display(unchecked)

        connected = network[current[end]]

        println(connected)

        for n in connected.neighbours
            new_path = deepcopy(current)
            push!(new_path, n)

            println(new_path)

            if network[n].flow > 0
                flow += network[n].flow * (30 - length(new_path))

                println(flow)

            end
            push!(unchecked, new_path)
        end

        if length(unique(current)) == length(keys(network)) || length(current)==30
            push!(checked, current)
            #println(current)
            #println("path completed")
        end

        t = t+1
    end

    println()
    return(checked)

end

#f = readlines("day16.txt")
t = readlines("test.txt")

grid, network = build_network(t)
#p = find_paths(network, 30)
