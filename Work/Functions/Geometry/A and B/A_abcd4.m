%Made by Nicolas Testard if there is any question

function A=A_abcd4(a0,a1,b0,b1,c0,c1,d0,d1)
A=B_abcd4(a0,a1,b0,b1,c0,c1,d0,d1)/5 + B_abcd5(a0,a1,b0,b1,c0,c1,d0,d1)/4 + ...
    B_abcd6(a0,a1,b0,b1,c0,c1,d0,d1)/3 + B_abcd7(a0,a1,b0,b1,c0,c1,d0,d1)/2 +...
    B_abcd8(a0,a1,b0,b1,c0,c1,d0,d1);
end