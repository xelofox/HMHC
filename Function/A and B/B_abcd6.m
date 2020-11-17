function B=B_abcd6(a0,a1,b0,b1,c0,c1,d0,d1)
B=a0*b0*(c1 - c0)*(d1 - d0) + a0*c0*(b1 - b0)*(d1 - d0) + a0*d0*(b1 - b0)*(c1 - c0)+b0*c0*(a1 - a0)*(d1 - d0) +...
    b0*d0*(a1 - a0)*(c1 - c0) + c0*d0*(a1 - a0)*(b1 - b0);
end