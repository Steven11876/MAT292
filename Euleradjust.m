function [t, y] = Euleradjust(yprime,t0,tN,y0,h)

t = [t0];
y = [y0];
step = h;

while t(end) < tN

    Y = y(end) + step* yprime(t(end), y(end));
    secondestimate = y(end) + step* yprime(t(end), y(end))/2;
    Z = secondestimate + step* yprime(t(end)+step/2, y(end)+secondestimate)/2;
    
    D = Y - Z;
    if abs(D) >= 0.00001
        step = 0.9*step*min(max(0.00001/abs(D),0.3),2);
    else
        t(end+1) = t(end) + step;
        y(end+1) = Y;
        step = h;
    end
end