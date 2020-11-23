%Made by Nicolas Testard if there is any question

function [Ti,Fi,Mi,Ec,Ep]=NE_one_body(Fj,Mj,segment,q,qd,qdd,CoM,Joint)
x=[1;0;0] ; y=[0;1;0] ; z=[0;0;1];
g=-9.81*y;

Rx=rot_x(q(4)*pi/180);
Ry=rot_x(q(4)*pi/180)*rot_y(q(5)*pi/180);
Rz=rot_x(q(4)*pi/180)*rot_y(q(5)*pi/180)*rot_z(q(6)*pi/180);

S0=(CoM-Joint);
Si=Rz*S0;

Omega=qd(4)*x+qd(5)*Rx*y+qd(6)*Ry*z;
Omega_d=qdd(4)*x+qdd(5)*Rx*y+qdd(6)*Ry*z;

m=segment.m;
I=segment.inertia;
I(1,1)=I(1,1)+m*(Si(2)^2+Si(3)^2);
I(2,2)=I(2,2)+m*(Si(1)^2+Si(3)^2);
I(3,3)=I(3,3)+m*(Si(1)^2+Si(2)^2);

Fi= Fj + m*g + m*qdd(1:3) + m*cross(Omega_d,S0) + m*mrot(Omega)*cross(Omega,S0);
Mi= Mj + cross(S0,m*g) + (Rz*I)*Omega_d + m*cross(S0,qdd(1:3)) + mrot(Omega)*( Rz*I * Omega );

% disp("poid:")
% disp(m*g)
% disp("accel")
% disp(transpose(m*qdd(1:3)))
% disp(transpose(m*cross(Omega_d,S0)))
% disp(transpose(m*mrot(Omega)*cross(Omega,S0)))

T1=Mi(1);
T2=Rx*Mi;
T3=Ry*Mi;
Ti= [T1(1);T2(2);T3(3)];

vm=qd(1:3)+cross(-S0,Omega);
Ec=0.5*m*vm'*vm+0.5*Omega'*(Rz*I)*Omega;
Ep=-m*g'*CoM;


end