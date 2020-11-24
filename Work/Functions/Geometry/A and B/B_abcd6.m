%Made by Nicolas Testard if there is any question

%This parameters are used to compute the inertia for ES group bodies
%according to the eqautions on pg 128
%The particular equations can be found on pg 130
function B=B_abcd6(a0,a1,b0,b1,c0,c1,d0,d1)
B=a0*b0*(c1 - c0)*(d1 - d0) + a0*c0*(b1 - b0)*(d1 - d0) + a0*d0*(b1 - b0)*(c1 - c0)+b0*c0*(a1 - a0)*(d1 - d0) +...
    b0*d0*(a1 - a0)*(c1 - c0) + c0*d0*(a1 - a0)*(b1 - b0);
end