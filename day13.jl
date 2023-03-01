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
            push!(pair, parse_pair(f[i]))
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

function parse_pair(s::String)
    count = 0
    n = length(s)
    s = s[2:end-1]

    if length(s) == 0
        return String[]
    end

    string = String[]
    substr = ""
    bracket_count = 0

    for char in s
        if char == '['
            bracket_count += 1
        end
        if char == ']'
            bracket_count -= 1
        end
        if bracket_count == 0 && char == ','
            push!(string, substr)
            substr = ""
        else
            substr = substr * char
        end
    end
    push!(string, substr)

    return(string)
end

pairs = getpairs(f)
