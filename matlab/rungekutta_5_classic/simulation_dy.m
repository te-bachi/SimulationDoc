% Flow calculation
function [ dy ] = simulation_dy(t, y)
	% Global constant parameters
    global D

	% Calculate / Interpolate
	v.value = y(1);
	s.value = y(2);

	% Parameter calculations

	% Flow calculations
	dv.value = -D.value*s.value;
	ds.value = v.value;

	dy      = zeros(2, 1);
	dy(1,1) = dv.value;
	dy(2,1) = ds.value;
end
