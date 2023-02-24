f = readlines("day06.txt")[1]

function marker(s::String, d::Int)
    n = length(s) - d
    marker_list = []
    for i in 1:n
        push!(marker_list, length(unique(s[i:(i+(d-1))])))
    end
    marker = findfirst(==(d), marker_list) + (d-1)
    return (marker)
end

#Part 1
println("Part 1: ")
packet_marker = marker(f, 4)
println(packet_marker)

#Part 2
println("Part 2: ")
msg_marker = marker(f, 14)
println(msg_marker)
