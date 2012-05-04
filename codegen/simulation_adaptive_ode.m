% Flow calculation
function [ sim_dy ] = simulation_adaptive_ode(sim_time, sim_y)
	% Global constant parameters
global Q R UR UB UC C I;

	% Convert vector to container
	Q.value = sim_y(1);

	% Parameter calculations
	UC.value = Q.value/C.value;
	UR.value = UB.value-UC.value;

	% Flow calculations
	I.value = UR.value/R.value;

	sim_dy = zeros(1, 1);
	sim_dy(1,1) = I.value;
end
