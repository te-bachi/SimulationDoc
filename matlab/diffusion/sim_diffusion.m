
function [g] = sim_diffusion(f, dt, a)
    [ylen xlen] = size(f);
    df = zeros(ylen, xlen);
    for y = 1:ylen
        for x = 1:xlen
            if x == 1 && y == 1
                df(y, x) = dt * a * (f(y+1, x) + f(y, x+1) - 2*f(y,x));
            elseif x == xlen && y == 1
                df(y, x) = dt * a * (f(y+1, x) + f(y, x-1) - 2*f(y,x));
            elseif x == 1 && y == ylen
                df(y, x) = dt * a * (f(y-1, x) + f(y, x+1) - 2*f(y,x));
            elseif x == xlen && y == ylen
                df(y, x) = dt * a * (f(y-1, x) + f(y, x-1) - 2*f(y,x));
            elseif x == 1
                df(y, x) = dt * a * (f(y+1, x) + f(y-1, x) + f(y, x+1) - 3*f(y,x));
            elseif x == xlen
                df(y, x) = dt * a * (f(y+1, x) + f(y-1, x) + f(y, x-1) - 3*f(y,x));
            elseif y == 1
                df(y, x) = dt * a * (f(y+1, x) + f(y, x+1) + f(y, x-1) - 3*f(y,x));
            elseif y == ylen
                df(y, x) = dt * a * (f(y-1, x) + f(y, x+1) + f(y, x-1) - 3*f(y,x));
            else
                df(y, x) = dt * a * (f(y+1, x) + f(y-1, x) + f(y, x+1) + f(y, x-1) - 4*f(y,x));
            end;
        end;
    end;
    g = f + df;
end

