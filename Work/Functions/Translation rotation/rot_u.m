%Made by Nicolas Testard if there is any question

function R=rot_u(u,theta)

u1=u;

if ( mean(size(u1)==[1,3]) )
    u1=transpose(u1);
end

P=u*u';
I=eye(3);
Q=mrot(u);

R=P+cos(theta)*(I-P)+sin(theta)*Q;

end