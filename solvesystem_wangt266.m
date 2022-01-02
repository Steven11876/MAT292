function [t, x] = euler2(x11, x21, t0, tN, x0, h)

t = t0:h:tN+h;
stepsize = length(t);
x1 = x0(1)+zeros(1,stepsize-1);
x2 = x0(2)+zeros(1,stepsize-1);
a=1;
for i = t-1
    m0 = x11(i,x1(a), x2(a));
    m1 = x21(i,x1(a), x2(a));
    m00 = x11(i+h,x1(a)+h*m0, x2(a)+m1*h);
    m11 = x21(i+h, x1(a)+m0*h, x2(a)+m1*h);
    x1(a+1) = x1(a)+h*(m0+m00)/2;
    x2(a+1) = x2(a)+h*(m1+m11)/2;  
    a = a+1;
    
end

x=[x1;x2];

end
    
    


