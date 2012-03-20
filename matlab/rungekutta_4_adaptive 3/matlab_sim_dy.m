%% % Alle Flüsse
function [ dy ] = matlab_sim_dy(x, y)
    dy = zeros(2, 1);
    dy(1) = y(2);
    dy(2) = -5*sin(y(1));
end

