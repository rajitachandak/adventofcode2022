f = readlines("day13.txt")

function getpairs(f::Vector{String})
    pairs = []
    n = length(f)
    pair = []
    for i in 1:n
        if f[i] == ""
            push!(pairs, pair)
            pair = []
        else
            push!(pair, f[i])
        end
    end
    return(pairs)
end

pairs = getpairs(f)
