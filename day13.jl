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
    elseif l > r
        return false
    else
        return NaN
    end
end

function compare_values(l::Vector{String}, r::Vector{String})

    if l[1] == "[" && r[1] == "["
        popfirst!(l)
        popfirst!(r)
        compare_values(l, r)
    elseif l[1] == "["
    elseif l[1] == "]" && r[1] != "]"
        return true
    elseif l[1] == "]" && r[1] == "]"
        popfirst!(l)
        popfirst!(r)
        compare_values(l, r)
    else
       return compare_values(parse(Int, l[1]), parse(Int, r[1]))
    end

end

function parse_pairs(pairs::Vector{String})
    count = 0
    n = length(pairs)
    for i in 1:n
        l = pairs[i][1]
        r = pairs[i][2]
    end
end

pairs = getpairs(f)
