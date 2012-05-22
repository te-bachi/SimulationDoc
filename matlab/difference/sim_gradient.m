
function [dx dy] = sim_gradient(f)
    [ylen xlen] = size(f);
    dx = zeros(ylen, xlen);
    dy = zeros(ylen, xlen);
    for y = 1:ylen
        for x = 1:xlen
            if x == xlen || y == ylen
                dx(y,x) = 0;
                dy(y,x) = 0;
            else
                dx(y,x) = f(y, x + 1) - f(y, x);
                dy(y,x) = f(y + 1, x) - f(y, x);
            end;
        end;
    end;
end
