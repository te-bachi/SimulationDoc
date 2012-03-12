%% Flows
% x     = TIME
% y(1)  = Q
% dy(1) = Q' = I
function [ dy ] = simulation_dy(x, y)
    global Q R UB C UC UR i dt;

	% Flow calculations
	I.value(i)=UR.value/R.value;

    %% Container calculations
    Q.value(i) = y(1,1);
    dy      = zeros(1, 1);
    dy(1,1) = I.value(i);
    %%

	% Parameter calculations
    R.value(i) = 1250.0; % constant
    UB.value(i) = 9.0; % constant
    C.value(i) = 5.2E-4; % constant
	UC.value(i)=Q.value(i)/C.value(i);
	UR.value(i)=UB.value(i)-UC.value(i);
    
    R.time(i) = x;
    UB.time(i) = x;
    C.time(i) = x;
    UC.time(i) = x;
    UR.time(i) = x;
    
    if x > dt
        i = i + 1;
    end;
    
    dt = x;
    
end

