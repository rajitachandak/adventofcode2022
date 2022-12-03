#part 1
f=readlines("day2.txt")

results = Dict(
    "A X"=>1+3,
    "A Y"=>2+6,
    "A Z"=>3+0,
    "B X"=>1+0,
    "B Y"=>2+3,
    "B Z"=>3+6,
    "C X"=>1+6,
    "C Y"=>2+0,
    "C Z"=>3+3
)
println(results[f[1]])

let score=0
    for i in 1:length(f)
        score+=results[f[i]]
    end
println(score)
end

#part 2
A=1
B=2
C=3
X=0
Y=3
Z=6
part2_results = Dict(
    "A X"=>3+0,
    "A Y"=>1+3,
    "A Z"=>2+6,
    "B X"=>1+0,
    "B Y"=>2+3,
    "B Z"=>3+6,
    "C X"=>2+0,
    "C Y"=>3+3,
    "C Z"=>1+6
)

let score=0
    for i in 1:length(f)
        score+=part2_results[f[i]]
    end
    println("Part 2 total:")
    println(score)
end
