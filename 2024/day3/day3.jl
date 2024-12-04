r1 = r"(mul\([0-9]*,[0-9]*\))"
r2 = r"([0-9]+)"
r3 = r"(do\(\)|don't\(\)|mul\([0-9]*,[0-9]*\))"

readlines("input.txt") |> join |> s -> map(m->m.match, eachmatch(r1,s)) |>
    s->map(st->map(m->parse(Int64,m.match), eachmatch(r2,st)),s) |>
    s->reduce((acc, v)-> acc+v[1]*v[2], s,init=0) |> println

readlines("input.txt") |> join |> s -> map(m->m.match ,eachmatch(r3,s)) |> s -> map(st->st != "do()"&&st!="don't()" ? map(m->parse(Int64,m.match), eachmatch(r2,st)) : st,s) |>
    a->reduce((acc,v)->(typeof(v) == Vector{Int64} ? acc[1]+acc[2]*v[1]*v[2] : acc[1] , typeof(v)!=Vector{Int64} ? v=="do()" : acc[2]),a,init=[0,true])[1] |> println
