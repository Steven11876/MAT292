%% Systems Lab: Systems of ODEs in MATLAB
%
% In this lab, you will write your own ODE system solver for the Heun method 
% (aka the Improved Euler method), and compare its results to those of |ode45|.
%
% You will also learn how to save images in MATLAB.
% 
% Opening the m-file lab4.m in the MATLAB editor, step through each
% part using cell mode to see the results.  Compare the output with the
% PDF, which was generated from this m-file.
%
% There are four (4) exercises in this lab that are to be handed in on the
% due date of the lab.  Write your solutions in a separate file, including
% appropriate descriptions in each step. Save the m-files and the pdf-file 
% for Exercise 4 and submit them on Quercus.
%
%% Student Information
%
%  Student Name: Tianjian  Wang
%
%  Student Number: 1006848716
%

%Exercise 2


t0 = 0;
tN = 4*pi;
x0 = [1; 1];
h = 0.05;

x11 = @(t, x1, x2) 0.5.*x1-2.*x2;
x21 = @(t, x1, x2) 5.*x1 - x2;
[t1, y1] = solvesystem_wangt266(x11, x21, t0, tN, x0, h);

tt = 0:0.05:4*pi;
y11 = @(t) exp(-t/4) .* (cos(sqrt(151).*t/4) - 5 .* sqrt(151) .* sin(sqrt(151).*t/4)./151);
y22 = @(t) exp(-t/4) .* (cos(sqrt(151).*t/4) + 17 .* sqrt(151) .* sin(sqrt(151).*t/4)./151);


plot(y1(1,:), y1(2,:), y11(tt), y22(tt));
title('Hueun vs Exact Solution');
legend('Exact Solution', 'Hueun');
xlabel('x1');
ylabel('x2');


%% Exercise 3

y = @(t, x) [x(1)./2-2.*x(2);5.*x(1)-x(2)];

eu = euler(y, x0 ,t1);

plot(y1(1,:), y1(2,:), eu(1,:), eu(2,:), y11(tt), y22(tt));
xlabel("x1");
ylabel("x2");
title('Hueun vs Exact Solution vs Euler Method');
legend("Hueun", "Euler's", "Exact");
