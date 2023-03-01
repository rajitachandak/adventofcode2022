
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
    push!(pairs, pair)
    return(pairs)
end

function parse_pair(s::String)
    @assert s[1] == '['
    @assert s[end] == ']'
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

function check_int(s::String)

    if all(c in '0':'9' for c in s)
        return true
    else
        return false
    end

end

function compare_values(l::Int, r::Int)

    if l < r
        return true
    elseif l > r
        return false
    else
        return nothing
    end

end

function compare_values(l::String, r::String)

    if check_int(l) && check_int(r)
        return compare_values(parse(Int, l), parse(Int, r))

    elseif !check_int(l) && check_int(r)
        return compare_values(parse_pair(l), [r])

    elseif check_int(l) && !check_int(r)
        return compare_values([l], parse_pair(r))

    elseif !check_int(l) && !check_int(r)
        return compare_values(parse_pair(l), parse_pair(r))
    end

end

function compare_values(l::Vector{String}, r::Vector{String})
    min_len = min(length(l), length(r))

    for i in 1:min_len
        state = compare_values(l[i], r[i])
        if state == true
            return true
        end
        if state == false
            return false
        end
    end

    if length(l) < length(r)
        return true
    elseif length(l) > length(r)
        return false
    else
        return nothing
    end

end


f = readlines("day13.txt")

#Part 1
pairs = getpairs(f)
correct = []
for i in 1:length(pairs)
    l = pairs[i][1]
    r = pairs[i][2]
    result = compare_values(l, r)
    if result
        push!(correct, i)
    end
end
println("Part 1: ", sum(correct))
