f = readlines("day11.txt")

mutable struct Monkey
    items::Vector{Int}
    operation::Function
    div::Int
    throw
end

function op0(x::Int)
    new = x*3
    return(new)
end
function op1(x::Int)
    new = x+2
    return(new)
end
function op2(x::Int)
    new = x+1
    return(new)
end
function op3(x::Int)
    new = x+5
    return(new)
end
function op4(x::Int)
    new = x+4
    return(new)
end
function op5(x::Int)
    new = x+8
    return(new)
end
function op6(x::Int)
    new = x*7
    return(new)
end
function op7(x::Int)
    new = x*x
    return(new)
end

function create_monkeys()

    Monkey0 = Monkey([53, 89, 62, 57, 74, 51, 83, 97], op0, 13, nothing)
    Monkey1 = Monkey([85, 94, 97, 92, 56], op1, 19, nothing)
    Monkey2 = Monkey([86, 82, 82], op2, 11, nothing)
    Monkey3 = Monkey([94, 68], op3, 17, nothing)
    Monkey4 = Monkey([83, 62, 74, 58, 96, 68, 85], op4, 3, nothing)
    Monkey5 = Monkey([50, 68, 95, 82], op5, 7, nothing)
    Monkey6 = Monkey([75], op6, 5, nothing)
    Monkey7 = Monkey([92, 52, 85, 89, 68, 82], op7, 2, nothing)
    Monkey0.throw = [Monkey1, Monkey5]
    Monkey1.throw = [Monkey5, Monkey2]
    Monkey2.throw = [Monkey3, Monkey4]
    Monkey3.throw = [Monkey7, Monkey6]
    Monkey4.throw = [Monkey3, Monkey6]
    Monkey5.throw = [Monkey2, Monkey4]
    Monkey6.throw = [Monkey7, Monkey0]
    Monkey7.throw = [Monkey0, Monkey1]

    Monkeys = [Monkey0, Monkey1, Monkey2, Monkey3, Monkey4, Monkey5, Monkey6, Monkey7]

    return(Monkeys)
end

function div(x::Int, y::Int)
    div = mod(x, y)
    if div == 0
        return(true)
    else
        return(false)
    end
end

function throw_item(worry::Int, result::Bool, monkeylist)
    if result == true
        push!(monkeylist[1].items, worry)
    else
        push!(monkeylist[2].items, worry)
    end
end

function inspect(input::Vector{Monkey})

    M = deepcopy(input)

    items_inspected = [0, 0, 0, 0, 0, 0, 0, 0]
    for rounds in 1:20
        for i in 1:8
            m = M[i]
            items_inspected[i] += length(m.items)
            for j in 1:length(m.items)
                item = popfirst!(m.items)
                worry = floor(Int, m.operation(item)/3)
                test = div(worry, m.div)
                throw_item(worry, test, m.throw)
            end
        end
    end
    items_inspected = sort(items_inspected, rev=true)
    return(items_inspected)
end

Monkeys=create_monkeys()
items_inspected = inspect(Monkeys)

println("Part 1: ", items_inspected[1] * items_inspected[2])

function controlled_inspection(input::Vector{Monkey})

    M = deepcopy(input)

    divs=[]
    for m in M
        push!(divs, m.div)
    end
    k = reduce(lcm, divs)

    items_inspected = [0, 0, 0, 0, 0, 0, 0, 0]
    for rounds in 1:10000
        for i in 1:8
            m = M[i]
            items_inspected[i] += length(m.items)
            for j in 1:length(m.items)
                item = popfirst!(m.items)
                worry = mod(m.operation(item), k)
                test = div(worry, m.div)
                throw_item(worry, test, m.throw)
            end
        end
    end
    items_inspected = sort(items_inspected, rev=true)
    return(items_inspected)
end

items_inspected = controlled_inspection(Monkeys)
println("Part 2: ", items_inspected[1] * items_inspected[2])
