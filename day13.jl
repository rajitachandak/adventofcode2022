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

function compare_values(l::Int, r::Int)

    if l < r
        return true
    else if l > r
        return false
    else
        return NaN
    end
end

function compare_values(l::Vector{String}, r::Vector{String})

    if l[1] == "["
        popfirst!(l)
    else if l[1] == "]"
    else
        compare_values(parse(Int, l[1]), parse(Int, r[1]))
    end

end

pairs = getpairs(f)
