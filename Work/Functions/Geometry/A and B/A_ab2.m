
%This parameters are used to compute the inertia for ES group bodies
%according to the eqautions on pg 128
%The particular equations can be found on pg 129
%(small reminder: the ci and di parameters = ai and bi respectivelly)
function A=A_ab2(a0,a1,b0,b1)
A=B_ab1(a0,a1,b0,b1)/4+B_ab2(a0,a1,b0,b1)/3+B_ab3(a0,a1,b0,b1)/2;
end