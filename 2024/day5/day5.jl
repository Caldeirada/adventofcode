rules = readlines("input_rules.txt") |> m->map(r->map(n->parse(Int64,n),split(r,"|")),m)
pages = readlines("input_pages.txt")|>r->map(l->map(n->parse(Int64,n),split(l,",")),r)

function is_sort(v, rules)
    return map(i->filter(r->i in r,rules),v)|>n->unique(reduce(vcat,n))|>r->map(l->map(t->findfirst(==(t),v),l),r) |>
    r->map(l->nothing in l||l[1]<l[2],r) |> r->reduce(&,r)
end

function get_swaps(v, rules)
    return map(i->filter(r->i in r,rules),v)|>r->unique(reduce(vcat,r))|>
        r->map(l->map(t->findfirst(==(t),v),l),r)|> r-> filter(l->!(nothing in l)&&l[1]>l[2],r)
end

function swap_ind(v, swaps, rules)
    i, j = swaps[1]
    v[i], v[j] = v[j], v[i]
    if is_sort(v,rules)
        return (v)
    else
        swaps = get_swaps(v,rules)
        swap_ind(v, swaps, rules)
    end
end

filter(p->p |> n->map(i->filter(r->i in r,rules),n)|>n->unique(reduce(vcat,n))|>r->map(l->map(t->findfirst(==(t),p),l),r) |>
    r->map(l->nothing in l||l[1]<l[2],r) |> r->reduce(&,r),pages) |> r-> reduce((acc,l)->acc+l[ceil(Int64,length(l)/2)],r,init=0) |> println
map(p->p |> n->map(i->filter(r->i in r,rules),n)|>n->unique(reduce(vcat,n))|>
    r->map(l->map(t->findfirst(==(t),p),l),r) |> r->[r,map(l->nothing in l||l[1]<l[2],r)] |>
    r->[r[1],reduce(&,r[2])]|> r->[r[1],map(l->!l ? p : nothing,r[2])],pages) |> r->filter(l->l[2]!=nothing,r) |>
    r->map(l->[filter(n->!(nothing in n),l[1]),l[2]],r) |> r->map(l->[filter(n->n[1]>n[2],l[1]),l[2]],r) |>
    r -> map(v->swap_ind(v[2],v[1], rules),r)|> r-> reduce((acc,l)->acc+l[ceil(Int64,length(l)/2)],r,init=0) |> println
