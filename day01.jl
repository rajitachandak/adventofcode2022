#part 1
f=readlines("day01.txt")
total = []
let tot = 0
    for i in 1:length(f)
        if f[i]==""
           push!(total, tot )
           tot=0
        else
          tot+=parse(Float64,f[i])
       end
     end
end
println(maximum(total))

#part 2
sort!(total, rev=true)
println(sum(total[1:3]))
