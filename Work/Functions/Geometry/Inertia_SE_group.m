%Made by Nicolas Testard if there is any question

function I=Inertia_SE_group(segment)
a=segment.a;
b=segment.b;
c=segment.c;
m=segment.m;

I=zeros(3,3);
I(1,1)=m*(b^2+c^2)/5;
I(2,2)=m*(a^2+c^2)/5;
I(3,3)=m*(a^2+b^2)/5;
end