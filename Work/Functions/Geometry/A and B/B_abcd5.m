%Made by Nicolas Testard if there is any question

function B=B_abcd5(a0,a1,b0,b1,c0,c1,d0,d1)
B=a0*(b1 - b0)*(c1 - c0)*(d1 - d0) + b0*(a1 - a0)*(c1 - c0)*(d1 - d0)+c0*(a1 - a0)*(b1 - b0)*(d1 - d0) + d0*(a1 - a0)*(b1 - b0)*(c1 - c0);
end