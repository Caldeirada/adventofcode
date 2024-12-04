function parse_input(input)
    return map(l -> map(r->parse(Int64,r),split(l)),readlines(input))
end

function check_valid(seq)
    return map(b -> map(i -> b[i]-b[i+1], 1:length(b)-1),[seq]) |> a-> map(c->(c,[length(filter(b-> b==0,c))>0]), a) |>
    a -> map(c->(c[1],push!(c[2],length(filter(b -> abs(b) <= 3, c[1]))!=length(c[1]))),a) |>
    a -> map(c-> (c[1],push!(c[2],length(unique(map(sign,filter(b->b!=0,c[1]))))!=1)),a) |>
    a -> map(b->sum(b[2]),a)
end

function brute_force(seq)
    valid = false
    for i in 1:length(seq)
        if !valid
            new_seq = seq[1:end .!=i]
            valid = check_valid(new_seq)[1] == 0
        end
    end
    return valid
end

parse_input("input.txt") |> a->map(b -> map(i -> b[i]-b[i+1], 1:length(b)-1),a)|> a->filter(c->length(filter(b-> b!=0,c))==length(c),a) |>
    a -> filter(c->length(filter(b -> abs(b) <= 3, c))==length(c),a) |> a -> filter(c-> length(unique(map(sign,c)))==1,a) |> length |> println

parse_input("input.txt") |> a-> filter(b->brute_force(b),a) |> length |> println
