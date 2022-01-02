
function [y, t] = heun(yprime,t0,tN,y0,h)

t = t0:h:tN; 
stepsize = length(t);
y = y0 + zeros(1, stepsize);

for i = 1:stepsize-1
	estimate = y(i)+ h*yprime(t(i), y(i));
	y(i + 1) = y(i)+ h*(yprime(t(i), y(i)) + yprime(t(i + 1), estimate))/2;
end

