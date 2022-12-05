#Trying out functions in julia
function splitstring(s)
    (r,t) = split(s, ",")
    return (r, t)
end

function getrange(s)
    (r, t) = split(s, "-")
    r = parse(Int, r)
    t = parse(Int, t)
    return (r, t)
end

function string_contains(s, t)
    if s[1]<=t[1] && s[2]>=t[2]
        return 1
    elseif t[1]<=s[1] && t[2]>=s[2]
        return 1
    else
        return 0
    end
end

open("day4.txt") do f
    counter = 0
    for l in eachline(f)
        (s, t) = splitstring(l)
        s_range = getrange(s)
        t_range = getrange(t)
        counter += string_contains(s_range, t_range)
    end
    println("Part 1:", counter)
end
