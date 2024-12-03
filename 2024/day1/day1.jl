# part 1
function parse_input(input)
    return reduce((acc, v) -> (push!(acc[1], v[1]),push!(acc[2], v[2])),map(l -> map(r->parse(Int64,r),split(l)),readlines(input)), init = [Int[],Int[]])
end

parse_input("input1.txt") |> loc -> map(l->sort(l), loc) |> loc -> loc[1] - loc[2] |> loc -> reduce((acc, l)->acc+abs(l),loc,init = 0) |> println
parse_input("input1.txt") |> loc -> map(l -> (l, length(filter(r->r==l,loc[2]))), loc[1]) |> loc -> reduce((acc, l)->acc+l[1]*l[2],loc,init=0) |> println
