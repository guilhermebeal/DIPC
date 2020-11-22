function [ y ] = sat_fn( u )

if abs(u) >= 1
    y = sign(u);
else
    y = u;
end

end