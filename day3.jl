open("day3.txt") do f
    for l in eachline(f)
        halflen = trunc(Int, length(l)/2)
        println("check")
        println(l)
        l1 = SubString(l, 1, halflen)
        l2 = SubString(l, halflen+1)
        println((?l1)(.*)(?l2))
    end
end
