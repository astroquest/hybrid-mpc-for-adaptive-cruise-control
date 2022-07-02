%%% Original continuous-time dynamics of the following vehicle with gear
%%% switching.

if 0 <= v(k) && v(k) < v_12
    g = 1;
elseif v_12 <= v(k) && v(k) < v_23
    g = 2;
elseif v(k) >= v_23
    g = 3;
end

a(k) = 1/m * b/(1+gamma*g) * u(k) - 1/m * c*v(k)^2;