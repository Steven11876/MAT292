%% Second-Order Lab: Second-Order Linear DEs in MATLAB
%
%
% In this lab, you will learn how to use |iode| to plot solutions of 
% second-order ODEs. You will also learn to classify the behaviour of 
% different types of solutions.
%
% Moreover, you will write your own Second-Order ODE system solver, and 
% compare its results to those of |iode|.
%
% Opening the m-file lab5.m in the MATLAB editor, step through each
% part using cell mode to see the results.
%
% There are seven (7) exercises in this lab that are to be handed in on the
% due date of the lab.
%
%% Student Information
%
%  Student Name: Tianjian Wang
%
%  Student Number: 1006848716

%1

%b) All solutions decay while oscillating. 

%c) The  solution is y=e^(-t/2)* (c1*cos(2t)+c2*sin(2t)). 
% The e^(-t/2) term goes to 0 as t becomes larger and the sin and cos term
% make it oscillate

%% Exercise 2


%b) Most solutions grow, but the one solution at y=0 with slope=0 decays. 
%c) The exact solution is  y= (c1*e^(((-sqrt(3)+2)/2)t)) +
%(c2*e^c1*e^(((-sqrt(3)-2)/2)t)). As t goes to infinity, y also goes to
%plusminus infinity. However, if y=0, y'=0, and y''=0 at the initial condition, it will stay at this
%state indefinitely. There is also no oscillations, no sin, cos, etc. 

%% Exercise 3

%b) All solutions decay. 
%c) y = c1*e^((-sqrt(3) + sqrt(2))t/2)+c2*e^((-sqrt(3) - sqrt(2))t/2). The
%exponential terms are negative so the solution decays. There is no sin or
%cos so there are no oscillations.  

%% Exercise 4
%a)  The roots are -1.0000 + 2.0000i, -1.0000 - 2.0000i, 1.0000i, - 1.0000i
% The solution is c1*cos(t) + c2*sin(t) + c3 * e^(-t)*sin(2t) +
% c4*e^(-t)*cos(2t)

%b) The first two roots cause the solution to decay while oscillating
%because they have an imaginary component and a negative real component.
%The last two roots cause indefinite oscillations because they have no real
%component. Half of the solutions decay while oscillating and half
%oscillate indefinitely. 

%% Exercise 5
%

% a. Grows
% b. Half of solutions grow half decays
% c. Decays
% d. Decays while oscillating
% e. Center (oscillating) - Does not grow or decay
% f. Grows while oscillating


%% Exercise 7
%


f = @(t, y, yy) -exp(-t/5)*yy-(1-exp(-t/5))*y+sin(2*t);

[t, y] = DE2_wangt266(f, 0, 20, 1, 0, 0.01);

plot(t, y);
title('Solution Comparison');
xlabel('t');
ylabel('y');
legend('Estimated Solution');


% The plot looks mostly the same. The values may be slightly off in places. 
