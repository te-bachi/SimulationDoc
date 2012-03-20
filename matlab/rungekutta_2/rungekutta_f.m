function y=rungekutta_f(x)
    y = zeros(2, 1);
    y(1) = x(2);
    y(2) = -9.81;
end