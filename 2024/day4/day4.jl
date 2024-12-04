function get_words(indx,indy, m)
    words = Vector{String}()
    if length(m[indy])-indx >= 3
        push!(words, join(m[indy][indx:indx+3]))
    end
    if length(m)-indy >= 3
        push!(words, string(m[indy][indx],m[indy+1][indx],m[indy+2][indx],m[indy+3][indx]))
    end
    if length(m[indy])-indx >= 3&&length(m)-indy >= 3
        push!(words, string(m[indy][indx],m[indy+1][indx+1],m[indy+2][indx+2],m[indy+3][indx+3]))
    end
    if indx > 3&&length(m)-indy >= 3
        push!(words, string(m[indy][indx],m[indy+1][indx-1],m[indy+2][indx-2],m[indy+3][indx-3]))
    end
    return filter!(w-> w=="XMAS"||w=="SAMX",words)
end
function get_x_mas(indx,indy, m)
    words = Vector{String}()
    if 1<indx<length(m[indy])&&1<indy<length(m)
        push!(words, string(m[indy-1][indx-1],m[indy][indx],m[indy+1][indx+1]))
        push!(words, string(m[indy-1][indx+1],m[indy][indx],m[indy+1][indx-1]))
    end
    return filter!(w-> w=="MAS"||w=="SAM",words)
end
readlines("input.txt") |> m -> map(collect, m) |> m -> map(((i,c),)-> map(((j,cr),)->get_words(j,i,m),enumerate(c)),enumerate(m)) |>
    m-> reduce(vcat,m) |> m->filter(c->length(c)>0,m) |> m-> reduce(vcat,m) |> length |> println
readlines("input.txt") |> m -> map(collect, m) |> m -> map(((i,c),)-> map(((j,cr),)->get_x_mas(j,i,m),enumerate(c)),enumerate(m)) |>
    m-> reduce(vcat,m) |> m->filter(c->length(c)>1,m) |> length |> println
