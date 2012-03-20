%% Flows
% t     = TIME
% y(1)  = Q
% dy(1) = Q' = I
function [ dy ] = simulation_dy(t, y)
    dy = zeros(2, 1);
    dy(1) = y(2);
    dy(2) = -5*sin(y(1));
end

