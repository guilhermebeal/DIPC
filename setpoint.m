function [ r ] = setpoint( t )

r = 0;

if t > 20
    r = 5;
end
if t > 30
    r = 10;
end
if t > 40
    r = 5;
end

end