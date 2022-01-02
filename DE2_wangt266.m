function [t, y] = DE2_wangt266(f,t0,tN,y0,y1,h)
    t = t0 : h : tN+h;     
    y = zeros(1,length(t));  
    y(1) = y0;
    y(2) = y0 + y1*h;
    for i = 3: length(t)-2
        slope = (y(i-1) - y(i-2))/h;
        y(i) = (h^2)*f(t(i-1), y(i-1), slope) + 2*y(i-1)- y(i-2);
    end
end
        
        