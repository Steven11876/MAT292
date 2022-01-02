%% Laplace Transform Lab: Solving ODEs using Laplace Transform in MATLAB
%
% This lab will teach you to solve ODEs using a built in MATLAB Laplace 
% transform function |laplace|.
%
% There are five (5) exercises in this lab that are to be handed in.  
% Write your solutions in a separate file, including appropriate descriptions 
% in each step.
%
% Include your name and student number in the submitted file.
%
%% Student Information
%
%  Student Name: Tianjian Wang
%
%  Student Number: 1006848716
%


%% Exercise 1

% (a) Define the function |f(t)=exp(2t)*t^3|, and compute its Laplace
%   transform |F(s)|.
syms t s
f = exp(2*t)*t^3;
F = laplace(f)

% (b) Find a function |f(t)| such that its Laplace transform is
%   |(s - 1)*(s - 2))/(s*(s + 2)*(s - 3)|

F = ((s-1)*(s-2))/(s*(s+2)*(s-3));
f=ilaplace(F)


% (c) Show that MATLAB 'knows' that if |F(s)| is the Laplace transform of
%   |f(t)|, then the Laplace transform of |exp(at)f(t)| is |F(s-a)| 

syms a f(t)
F1 = laplace(f(t))
F2 = laplace(exp(a*t)*f(t))

% Matlab recognizes the laplace transformations of functions multiplied by
% exp(a*t) to be shifted by a in the Laplace domain, as can be seen in the output. 

%% Exercise 2

syms t 

f=t;
g=t-1;

F=laplace(f)
G=laplace(heaviside(t-1)*g)

%In this proof, a was given a value of 1, and f was taken to be f=t. The
%laplace of f was found to be 1/s^2. The laplace transform of g was found
%to be exp(-s)/s^2. Hence, the laplace transmorm of u(t-a)*f(t-a) is
%equivalent to the laplace transform of u(t) multiplied by exp(-sa)

%% Exercise 3

% First we define the unknown function and its variable and the Laplace
% tranform of the unknown
syms y(t) t Y s
ODE = diff(y, t, 3) + 2* diff(y, t, 2) + diff(y, t, 1) + 2*y== -cos(t); % Then we define the ODE

L_ODE = laplace(ODE); % Now we compute the Laplace transform of the ODE.
L_ODE = subs(L_ODE, y(0), 0);% Use the initial conditions
L_ODE = subs(L_ODE, subs(diff(y, t, 1), t, 0), 0);
L_ODE = subs(L_ODE, subs(diff(y, t, 2), t, 0), 0);

L_ODE = subs(L_ODE, laplace(y, t, s), Y);% We now need to use the inverse Laplace transform to obtain the solution
% to the original IVP
Y = solve(L_ODE, Y);

y = ilaplace(Y) 

ezplot(y, [0, 10*pi]) %plot

% There is no initial condition for which |y| remains bounded as |t| goes
% to infinity. The particular solution to this ODE has no constant in
% front (cannot be set to 0), and always tends to infinity as t goes to infinity. Hence, the
% entire solution will tend to infinity as t goes to inifinity. 

%% Exercise 4

%define
syms y(t) t Y s

% Defne function
g = @(t) 3*heaviside(t)+(t-2)*heaviside(t-2)+( 4-t)*heaviside(t-5);
% Define ODE
ODE = diff(y,t,2)+2*diff(y,t,1)+5*y==g(t);
y0 = 2;% Initial
yprime1_0 = 1;

% Finding laplace transform using the initial conditions
L_ODE = laplace(ODE);
L_ODE = subs(L_ODE, y(0), 2);
L_ODE = subs(L_ODE, subs(diff(y, t, 1), t, 0), 1);% We now need to use the inverse Laplace transform to obtain the solution
% to the original IVP
L_ODE = subs(L_ODE, laplace(y, t, s), Y);
Y = solve(L_ODE, Y);
%inverse to find answer in t domain
y = ilaplace(Y);

% Plot solution
ezplot(y, [0, 12, 0, 2.25]);

%% Exercise 5

% Verify that MATLAB knowns about the convolution theorem by explaining why the following transform is computed correctly.
syms t tau y(tau) s
I=int(exp(-2*(t-tau))*y(tau),tau,0,t)
laplace(I,t,s)

% The laplace transform of this function gives the solution laplace(y(t),
% t, s)/(s+2). The laplace transform of an integral is the opposite of the
% laplace transform of a derivative. Instead of multiplying by s you divide
% by s. In this case, because of the exponent term shifting the solution by
% 2, we would expect the answet to be the laplace transform of y(t) divided
% by (s+2), which is what we got. 
% 

