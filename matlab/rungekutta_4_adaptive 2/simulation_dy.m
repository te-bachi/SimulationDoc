%% Flows
% t     = TIME
% y(1)  = Q
% dy(1) = Q' = I
function [ dy ] = simulation_dy(t, y)
    global s v;

	% Flow calculations
	ds.value = v.value;
    dv.value = -9.81;

    %% Container calculations
    s.value = y(1,1);
    v.value = y(2,1);
    
    dy = zeros(2, 1);
    dy(1) = ds.value;
    dy(2) = dv.value;
    %%

	% Parameter calculations
    
end

