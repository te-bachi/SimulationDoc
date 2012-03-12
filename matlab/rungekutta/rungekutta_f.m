function y=rungekutta_f(x)
    %y=[x(2); -5*sin(x(1))];
    
    y = zeros(2, 1);
    y(1) = x(2);
    y(2) = -5*sin(x(1));
end