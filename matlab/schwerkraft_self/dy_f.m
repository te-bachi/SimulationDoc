function [ dy ] = dy_f(x, y)
    dy = zeros(2, 1);
    dy(1) = y(2);
    dy(2) = -9.81;
end

