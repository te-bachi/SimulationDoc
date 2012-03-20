%% Flows
% x     = TIME
% y(1)  = Q
% dy(1) = Q' = I
function [ dy ] = matlab_dy(x, y)
    global R UB C;

    Q_interp = y(1);
    UC_interp = Q_interp/C.value;
    UR_interp = UB.value - UC_interp;
    I_interp = UR_interp / R.value;
    
    dy      = zeros(1, 1);
    dy(1,1) = I_interp;
    
end

