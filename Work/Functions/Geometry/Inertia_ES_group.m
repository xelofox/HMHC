%Made by Nicolas Testard if there is any question

%We use the equations of pg 128
function I=Inertia_ES_group(segment)
a1=segment.a1;
b1=segment.b1;
a0=segment.a0;
b0=segment.b0;
L=segment.L;
m=segment.m;

I=zeros(3,3);

I(1,1)=(1/4)*m*A_abcd4(a0,a1,b0,b1,b0,b1,b0,b1)/A_ab1(a0,a1,b0,b1) +...
    m*L^2*A_ab3(a0,a1,b0,b1)/A_ab1(a0,a1,b0,b1) -...
    m*( L*A_ab2(a0,a1,b0,b1)/A_ab1(a0,a1,b0,b1) )^2;

I(2,2)=(1/4)*m*A_abcd4(a0,a1,a0,a1,a0,a1,b0,b1)/A_ab1(a0,a1,b0,b1) +...
    m*L^2*A_ab3(a0,a1,b0,b1)/A_ab1(a0,a1,b0,b1) -...
    m*( L*A_ab2(a0,a1,b0,b1)/A_ab1(a0,a1,b0,b1) )^2;

I(3,3)=(1/4)*m*( A_abcd4(a0,a1,a0,a1,a0,a1,b0,b1) + A_abcd4(a0,a1,b0,b1,b0,b1,b0,b1) )/A_ab1(a0,a1,b0,b1);

end