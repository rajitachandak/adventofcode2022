f = readlines("day13.txt")
n=length(f)

global i=1
while i<n
    println(f[i])
    println(f[i+1])
    global i+=3
end
