%% Flows
% t     = TIME
% y(1)  = Q
% dy(1) = Q' = I
function [ dy ] = simulation_dy(t, y)
    global Q R UB C UC UR;

	% Flow calculations
	I.value=UR.value/R.value;

    %% Container calculations
    Q.value = y(1,1);
    dy      = zeros(1, 1);
    dy(1,1) = I.value;
    %%

	% Parameter calculations
	UC.value=Q.value/C.value;
	UR.value=UB.value-UC.value;
    
end

