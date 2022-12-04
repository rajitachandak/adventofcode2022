using StatsBase

alphabet = collect('a':'z')
points = collect(1:26)
mydict = Dict(alphabet .=> points)
for (k,v) in zip(collect('A':'Z'), collect(27:52))
    mydict[k] = v
end

open("day3.txt") do f
    letters = []
    score = 0
    for l in eachline(f)
        halflen = trunc(Int, length(l)/2)
        l1 = SubString(l, 1, halflen)
        l2 = SubString(l, halflen+1)
        push!(letters, intersect(l1,l2)[1])
    end
    for i in 1:length(letters)
        score+=mydict[letters[i]]
    end
    println("Part 1 total:")
    println(score)
end
