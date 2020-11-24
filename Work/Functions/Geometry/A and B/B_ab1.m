%Made by Nicolas Testard if there is any question

%This parameters are used to compute the inertia for ES group bodies
%according to the eqautions on pg 128
%The particular equations can be found on pg 130
function B=B_ab1(a0,a1,b0,b1)
B=(a1-a0)*(b1-b0);
end