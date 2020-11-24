%Made by Nicolas Testard if there is any question

%This parameters are used to compute the inertia for ES group bodies
%according to the eqautions on pg 128
%The particular equations can be found on pg 129
%(small reminder: the ci and di parameters = ai and bi respectivelly)
function A=A_abcd4(a0,a1,b0,b1,c0,c1,d0,d1)
A=B_abcd4(a0,a1,b0,b1,c0,c1,d0,d1)/5 + B_abcd5(a0,a1,b0,b1,c0,c1,d0,d1)/4 + ...
    B_abcd6(a0,a1,b0,b1,c0,c1,d0,d1)/3 + B_abcd7(a0,a1,b0,b1,c0,c1,d0,d1)/2 +...
    B_abcd8(a0,a1,b0,b1,c0,c1,d0,d1);
end
