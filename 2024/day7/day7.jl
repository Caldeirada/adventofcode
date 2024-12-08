# run with ulimit -s unlimited if using check_signal2
# or use the optimzed check_signal3
numbers = readlines("input.txt") |> m->map(r->split(r,": "),m) |> m->map(r->[parse(Int64,r[1]),map(l->parse(Int64,l),split(r[2]," "))],m)

function check_signal(total, values, i=0)
    ops = hcat(values[2:length(values)],digits(i, base=2, pad=length(values)-1))
    calibration = reduce((acc,v)-> v[2] == 0 ? acc + v[1] : acc * v[1] , eachrow(ops), init=values[1])

    if calibration == total
        return total
    elseif i < 2^(length(values)-1) - 1
        return check_signal(total, values, i+=1)
    else
        return 0
    end
end

function make_op(i,acc,v)
    if i == 0
        return acc+v
    elseif i == 1
        return acc*v
    else
        return parse(Int64,join(vcat(acc,v)))
    end
end

function check_signal3(total,values)
    i = 0
    calibration = 0
    while calibration != total && i < 3^(length(values)-1)
        ops = hcat(values[2:length(values)],digits(i, base=3, pad=length(values)-1))
        calibration = reduce((acc,v)-> make_op(v[2],acc,v[1]), eachrow(ops), init=values[1])
        if calibration == total
            return total
        end
        i+=1
    end
    return 0
end

function check_signal2(total, values, i=0)
    ops = hcat(values[2:length(values)],digits(i, base=3, pad=length(values)-1))
    calibration = reduce((acc,v)-> make_op(v[2],acc,v[1]), eachrow(ops), init=values[1])

    if calibration == total
        return total
    elseif i < 3^(length(values)-1) - 1
        return check_signal2(total, values, i+=1)
    else
        return 0
    end
end

map(n->check_signal(n[1],n[2]),numbers)|> sum |> println
map(n->(check_signal3(n[1],n[2])),numbers)|> sum |> println
