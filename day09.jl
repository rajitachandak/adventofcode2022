f = readlines("day09.txt")

function head_update(head::Vector, direction::SubString{String})
    if direction == "U"
        head = head + [0, 1]
    elseif direction == "D"
        head = head + [0, -1]
    elseif direction == "R"
        head = head + [1, 0]
    else
        head = head + [-1, 0]
    end

    return(head)
end

function move_rope(head::Vector, tail::Vector)
    x_dis = head[1] - tail[1]
    y_dis = head[2] - tail[2]
    if abs(x_dis)>1 || abs(y_dis)>1
        tail = [tail[1] + sign(x_dis), tail[2]+sign(y_dis)]
    end

    return(head, tail)
end

function rope_path(f::Vector{String})
    n =  length(f)
    visited = [[0,0]]
    curr_T = [0, 0]
    curr_H = [0, 0]
    for i in 1:n
        l = split(f[i], " ")
        direction = l[1]
        steps = parse(Int, l[2])
        for j in 1:steps
            curr_H = head_update(curr_H, direction)
            curr_H, curr_T = move_rope(curr_H, curr_T)
            push!(visited, curr_T)
        end
    end

    return (length(unique(visited)))
end
visited = rope_path(f)
println("Part 1: ", visited)

#Part 2
function long_rope_path(f::Vector{String})
    n =  length(f)
    visited = [[0,0]]
    head = [0, 0]
    knot1 = [0, 0]
    knot2 = [0, 0]
    knot3 = [0, 0]
    knot4 = [0, 0]
    knot5 = [0, 0]
    knot6 = [0, 0]
    knot7 = [0, 0]
    knot8 = [0, 0]
    tail = [0, 0]
    for i in 1:n
        l = split(f[i], " ")
        direction = l[1]
        steps = parse(Int, l[2])
        for j in 1:steps
            head = head_update(head, direction)
            head, knot1 = move_rope(head, knot1)
            knot1, knot2 = move_rope(knot1, knot2)
            knot2, knot3 = move_rope(knot2, knot3)
            knot3, knot4 = move_rope(knot3, knot4)
            knot4, knot5 = move_rope(knot4, knot5)
            knot5, knot6 = move_rope(knot5, knot6)
            knot6, knot7 = move_rope(knot6, knot7)
            knot7, knot8 = move_rope(knot7, knot8)
            knot8, tail = move_rope(knot8, tail)
            push!(visited, tail)
        end
    end

    return (length(unique(visited)))
end

long_visits = long_rope_path(f)
println("Part 2: ", long_visits)
