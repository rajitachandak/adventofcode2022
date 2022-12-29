using StatsBase

alphabet = collect('a':'z')
points = collect(1:26)
mydict = Dict(alphabet .=> points)
for (k,v) in zip(collect('A':'Z'), collect(27:52))
    mydict[k] = v
end

#Part 1
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

#Part 2
f = readlines("day3.txt")
badges = []
global part2score = 0
num_groups = trunc(Int, length(f)/3)
println(num_groups)
for l in 0:(num_groups-1)
    push!(badges,intersect(f[3*l+1], f[3*l+2], f[3*l+3])[1])
end
for i in 1:length(badges)
    global part2score+=mydict[badges[i]]
end
println("Part 2 total:")
println(part2score)
