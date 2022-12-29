f = readlines("day5.txt")
boxes = Dict(
    1 => ['R', 'G', 'H', 'Q', 'S', 'B', 'T', 'N'],
    2 => ['H', 'S', 'F', 'D', 'P', 'Z', 'J'],
    3 => ['Z', 'H', 'V'],
    4 => ['M', 'Z', 'J', 'F', 'G', 'H'],
    5 => ['T', 'Z', 'C', 'D', 'L', 'M', 'S', 'R'],
    6 => ['M', 'T', 'W', 'V', 'H', 'Z', 'J'],
    7 => ['T', 'F', 'P', 'L', 'Z'],
    8 => ['Q', 'V', 'W', 'S'],
    9 => ['W', 'H', 'L', 'M', 'T', 'D', 'N', 'C']
)

global multi_boxes = deepcopy(boxes)
global single_boxes = deepcopy(boxes)

function move_object(from_stack, to_stack, stacks::Dict)
    new_dict = stacks
    from_temp = pop!(new_dict, from_stack)
    to_temp = pop!(new_dict, to_stack)
    append!(to_temp, from_temp[end])
    pop!(from_temp)
    new_dict[from_stack] = from_temp
    new_dict[to_stack] = to_temp
    return(new_dict)
end

function move_stacks(from_stack, to_stack, num, stacks::Dict)
    new_dict = stacks
    from_temp = pop!(new_dict, from_stack)
    to_temp = pop!(new_dict, to_stack)
    append!(to_temp, last(from_temp, num))
    n = length(from_temp)
    deleteat!(from_temp, (n-num+1):n)
    new_dict[from_stack] = from_temp
    new_dict[to_stack] = to_temp
    return(new_dict)
end

#Part 1
num_moves = length(f)
for m in 11:num_moves
    strsplit = split(f[m], " ")
    num_iter = parse(Int, strsplit[2])
    from_stack = parse(Int, strsplit[4])
    to_stack = parse(Int, strsplit[6])
    for i in 1:num_iter
        global single_boxes = move_object(from_stack, to_stack, single_boxes)
    end
end

println("Part 1: ")
for j in 1:9
    print(single_boxes[j][end])
end
println(" ")

#Part 2
for m in 11:num_moves
    strsplit = split(f[m], " ")
    num_iter = parse(Int, strsplit[2])
    from_stack = parse(Int, strsplit[4])
    to_stack = parse(Int, strsplit[6])
    global multi_boxes = move_stacks(from_stack, to_stack, num_iter, multi_boxes)
end

println("Part 2: ")
for j in 1:9
    print(multi_boxes[j][end])
end
println(" ")
