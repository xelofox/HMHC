
%This parameters are used to compute the inertia for ES group bodies
%according to the eqautions on pg 128
%The particular equations can be found on pg 130
function B=B_abcd7(a0,a1,b0,b1,c0,c1,d0,d1)
B=b0*c0*d0*(a1 - a0) + a0*c0*d0*(b1 - b0) + a0*b0*d0*(c1 - c0) + a0*b0*c0*(d1 - d0);
end