function I=matrix_huygens(S)
a=abs(S(1));
b=abs(S(2));
c=abs(S(3));

I=[b^2+c^2, -a*b,    -a*c
    -a*b,   a^2+c^2, -b*c
    -a*c,    -b*c   a^2+b^2];
 
end