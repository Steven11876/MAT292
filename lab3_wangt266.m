%% ODE Lab: Creating your own ODE solver in MATLAB
%
% In this lab, you will write your own ODE solver for the Improved Euler 
% method (also known as the Heun method), and compare its results to those 
% of |ode45|.
%
% You will also learn how to write a function in a separate m-file and 
% execute it.
% 
% Opening the m-file lab3.m in the MATLAB editor, step through each
% part using cell mode to see the results.  Compare the output with the
% PDF, which was generated from this m-file.
%
% There are six (6) exercises in this lab that are to be handed in on the
% due date. Write your solutions in the template, including
% appropriate descriptions in each step. Save the .m files and submit them 
% online on Quercus.
%
%% Student Information
%
% Student Name: Tianjian Wang
%
% Student Number: 10068 1006848716
%

%% Creating new functions using m-files.
%  
% Create a new function in a separate m-file:
%
% Specifics:  Create a text file with the file name f.m
% with the following lines of code (text):
%
%  function y = f(a,b,c) 
%  y = a+b+c;
%
% Now MATLAB can call the new function f (which simply accepts 3 numbers
% and adds them together).  
% To see how this works, type the following in the matlab command window:
% sum = f(1,2,3)

%% Exercise 1
%
% Objective: Write your own ODE solver (using the Heun/Improved Euler
% Method).
%
% Details: This m-file should be a function which accepts as variables 
% (t0,tN,y0,h), where t0 and tN are the start and end points of the 
% interval on which to solve the ODE, y0 is the initial condition of the
% ODE, and h is the stepsize.  You may also want to pass the function into
% the ODE the way |ode45| does (check lab 2).
%
% Note: you will need to use a loop to do this exercise.  
% You will also need to recall the Heun/Improved Euler algorithm learned in lectures.  
%

%% Exercise 2
%
% Objective: Compare Heun with |ode45|.
%
% Specifics:  For the following initial-value problems (from lab 2, 
% exercises 1, 4-6), approximate the solutions with your function from
% exercise 1 (Improved Euler Method).
% Plot the graphs of your Improved Euler Approximation with the |ode45| 
% approximation.
%
% (a) |y' = y tan t + sin t, y(0) = -1/2| from |t = 0| to |t = pi|
%
% (b) |y' = 1 / y^2 , y(1) = 1| from |t=1| to |t=10|
%
% (c) |y' =  1 - t y / 2, y(0) = -1| from |t=0| to |t=10|
%
% (d) |y' = y^3 - t^2, y(0) = 1| from |t=0| to |t=1|
%
% Comment on any major differences, or the lack thereof. You do not need
% to reproduce all the code here. Simply make note of any differences for
% each of the four IVPs.

a = @(t, y) y*tan(t) + sin(t);


b = @(t, y) 1 / y^2;

c = @(t, y) 1 - (t*y)/2;



d = @(t, y) y^3 - t^2;

[y, t] = heun(c, 0, pi, -0.5, 0.1);
soln = ode45(c, [0, pi], -0.5);

plot(t, y, soln.x, soln.y, '-', 'MarkerSize',10, 'LineWidth', 2);

% Using H = 0.1
% For section a, there is not much difference. 
% For section b, there is some difference between 0<t<0.5. 
% For section c, there is some difference in the curve near 1.5. 
% For section d, there is some difference in the asymptote. 


%% Exercise 3
%
% Objective: Use Euler's method and verify an estimate for the global error.
%
% Details: 
%
% (a) Use Euler's method (you can use
% euler.m from iode) to solve the IVP
%
% |y' = 2 t sqrt( 1 - y^2 )  ,  y(0) = 0|
%
% from |t=0| to |t=0.5|.
%
% (b) Calculate the solution of the IVP and evaluate it at |t=0.5|.
%
% (c) Read the attached derivation of an estimate of the global error for 
%     Euler's method. Type out the resulting bound for En here in
%     a comment. Define each variable.
%
% (d) Compute the error estimate for |t=0.5| and compare with the actual
% error.
%
% (e) Change the time step and compare the new error estimate with the
% actual error. Comment on how it confirms the order of Euler's method.


%a) It was solved with IODE
equa = @(t, y) 2*t*( 1 - y^2 )^(1/2);
a = euler(equa, 0, 0:0.01:0.5);
plot(0:0.01:0.5, a);

%b) y = sin(t^2)for y(0) = 0

%c) E =< (1+M)t/2*(e^(M*t*n)-1) 
% Where M is the upper bound on dy/dt and dy/dx, n is steps number, t is step
% width, and E is global error. 

%d) First find M, find maxes of functions on t= (0, 0.5);f(0.5) = 2*0.5*sqrt(1-sin(0.5)^2) = 0.8776
% fy(0.5) = sin(0.5)/sqrt(1-sin(0.5)^2) = 0.5463
% fx(0) = 2(1-sin(0)^2)^(1/2) = 2
% M = 2
%stepwidth = 0.01
% steps number = 50
% E = 0.052 according to formula above. 

% The actual error is 0.005, below the upper limit of error. 

% e) The time step is changed to 0.001. The actual error becomes 0.0005.
% This is consistent with the formula as it shows the error decreases proportionally with step size, as Euler's method is first order. 

%% Adaptive Step Size
%
% As mentioned in lab 2, the step size in |ode45| is adapted to a
% specific error tolerance.
%
% The idea of adaptive step size is to change the step size |h| to a
% smaller number whenever the derivative of the solution changes quickly.
% This is done by evaluating f(t,y) and checking how it changes from one
% iteration to the next.

%% Exercise 4
%
% Objective: Create an Adaptive Euler method, with an adaptive step size |h|.
%
% Details: Create an m-file which accepts the variables |(t0,tN,y0,h)|, as 
% in exercise 1, where |h| is an initial step size. You may also want to 
% pass the function into the ODE the way |ode45| does.
%
% Create an implementation of Euler's method by modifying your solution to 
% exercise 1. Change it to include the following:
%
% (a) On each timestep, make two estimates of the value of the solution at
% the end of the timestep: |Y| from one Euler step of size |h| and |Z| 
% from two successive Euler steps of size |h/2|. The difference in these
% two values is an estimate for the error.
%
% (b) Let |tol=1e-8| and |D=Z-Y|. If |abs(D)<tol|, declare the step to be
% successful and set the new solution value to be |Z+D|. This value has
% local error |O(h^3)|. If |abs(D)>=tol|, reject this step and repeat it 
% with a new step size, from (c).
%
% (c) Update the step size as |h = 0.9*h*min(max(tol/abs(D),0.3),2)|.
%
% Comment on what the formula for updating the step size is attempting to
% achieve.

% The function is trying to ensure that step size is smaller when the error
% is larger, thus eliminating some error. This way, the program can perform
% less calculations, only evaluating precisely when it's needed. 

%% Exercise 5
%
% Objective: Compare Euler to your Adaptive Euler method.
%
% Details: Consider the IVP from exercise 3.
%
% (a) Use Euler method to approximate the solution from |t=0| to |t=0.75|
% with |h=0.025|.
%
% (b) Use your Adaptive Euler method to approximate the solution from |t=0| 
% to |t=0.75| with initial |h=0.025|.
%
% (c) Plot both approximations together with the exact solution.

equa = @(t, y) 2*t*( 1 - y^2 )^(1/2);
a = euler(equa, 0, 0:0.025:0.75);
t = [0, 0:0.025:0.75];
[solt, soly] = Euleradjust(equa, 0, 0.75, 0, 0.025);
y_real = sin(t.^2);
plot(t, y_real, 0:0.025:0.75, a, solt, soly);
legend('Exact', 'Euler', 'Adaptive Euler', 'Location', 'Best');


%% Exercise 6
%
% Objective: Problems with Numerical Methods.
%
% Details: Consider the IVP from exercise 3 (and 5).
% 
% (a) From the two approximations calculated in exercise 5, which one is
% closer to the actual solution (done in 3.b)? Explain why.
% 
% (b) Plot the exact solution (from exercise 3.b), the Euler's 
% approximation (from exercise 3.a) and the adaptive Euler's approximation 
% (from exercise 5) from |t=0| to |t=1.5|.
%
% (c) Notice how the exact solution and the approximations become very
% different. Why is that? Write your answer as a comment.

%a) euler's adaptive method is much closer. This is because it will
%regulate itself to lower its step size, and therefore error, when the
%error crosses a certain boundary. In this way, it limits the amount it can
%differ from the real solution. 

%b) 

equa = @(t, y) 2*t*( 1 - y^2 )^(1/2);
a = euler(equa, 0, 0:0.025:1.5);
t = [0, 0:0.025:1.5];
[solt, soly] = Euleradjust(equa, 0, 1.5, 0, 0.025);
y_real = sin(t.^2);
plot(t, y_real, 0:0.025:1.5, a, solt, soly);
legend('Exact', 'Euler', 'Adaptive Euler', 'Location', 'Best');

%c) The approximations differ towards the end. This is because imaginary
%parts of complex numbers were ignored because adaptive euler's method
%cannot interpret it. 
