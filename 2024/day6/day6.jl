maze = readlines("input.txt") |>m->map(r->collect(r),m)
start = findfirst(r -> '^' in r, maze) |> m->[maze[m],m] |> m-> [findfirst(r->r=='^',m[1]),m[2]]

direction = Dict([('^',[0,-1]),('<',[-1,0]),('>',[1,0]),('v',[0,1])])
next_pos = ((x,y), d) ->  [x+direction[d][1],y+direction[d][2]]
valid_pos = ((x,y), maze) ->  1<=x<=length(maze[1])&&1<=y<=length(maze)
is_wall = ((x,y),maze) -> maze[y][x]=='#'
rotation = Dict([('^','>'),('<','^'),('>','v'),('v','<')])

curr = [start, '^']

function walk(maze,curr,steps=Dict())
    s = curr[1]
    d = curr[2]
    next = next_pos(s,d)
    if !valid_pos(next,maze)
        steps[curr]=[s]
        return steps
    end
    if is_wall(next,maze)
        d = rotation[d]
        next = next_pos(s,d)
    end
    steps[curr]=[next]
    walk(maze,[next,d],steps)
end

pos = maze |>m -> walk(maze,curr)
values(pos)|>unique|>length|>println

function walk_loop(maze,curr,steps=Dict())
    s = curr[1]
    d = curr[2]
    next = next_pos(s,d)
    if !valid_pos(next,maze)
        return false
    end
    while is_wall(next,maze)
        d = rotation[d]
        next = next_pos(s,d)
    end
    if haskey(steps,[s,d])
        return true
    end
    if haskey(steps,[next,d])
        return true
    end
    steps[[s,d]]=next
    return walk_loop(maze,[next,d],steps)
end

loops = map(p->(m=deepcopy(maze);m[p[1][2]][p[1][1]]='#';walk_loop(m,curr) ? p : false) ,unique(values(pos))) |>r->filter(p->p!=false, r) |> unique
loops|>length|>println
