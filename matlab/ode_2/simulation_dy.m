%% Flows
% x     = TIME
% y(1)  = Q
% dy(1) = Q' = I
function [ dy ] = simulation_dy(x, y)
    global Q R UB C UC UR dt;

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

	% Save calculations
	fprintf(Q.fp, '%f\t%f\t%e\n', x, x - dt, Q.value);
	fprintf(R.fp, '%f\t%f\t%e\n', x, x - dt, R.value);
	fprintf(UR.fp, '%f\t%f\t%e\n', x, x - dt, UR.value);
	fprintf(UB.fp, '%f\t%f\t%e\n', x, x - dt, UB.value);
	fprintf(UC.fp, '%f\t%f\t%e\n', x, x - dt, UC.value);
	fprintf(C.fp, '%f\t%f\t%e\n', x, x - dt, C.value);
    
    dt = x;
    
end

