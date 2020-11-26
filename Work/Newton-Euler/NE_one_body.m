%Made by Nicolas Testard if there is any question
%Inputs
%   Fj = External Force applied to the body
%   Mj = External Torque applied to the body
%   segment = Name of the body part (struct variable)
%   q = vector of positions (Ji)
%   qd = vector of velocities (Jid)
%   qdd = vector of accelerations (Jidd)
%   CoM = Center of Mass of the body
%   Joint = Main frame of the body

%Outputs
%   Ti = Torque after applying it the Ji rotations (ask Nicolas ???)
%   Fi = Force of the main joint of the particular body part
%   Mi = Torque of the main joint of the particular body part
%   Ec = Kinetic Energy of the CoM of the body
%   Ep = Potential Energy of the CoM of the body

function [Ti,Fi,Mi,Ec,Ep]=NE_one_body(Fj,Mj,segment,q,qd,qdd,CoM,Joint)
x=[1;0;0] ; y=[0;1;0] ; z=[0;0;1];
g=-9.81*y;

%The three main rotations of the body among the local x, y and z angles
%relying on the 3 last values imported from each Ji vector
Rx=rot_x(q(4));
Ry=rot_x(q(4))*rot_y(q(5));
Rz=rot_x(q(4))*rot_y(q(5))*rot_z(q(6));

%S0 is the offset distance between our local frame, and its center of
%gravity
S0=(CoM-Joint);
%Si is the same offset S0 after the rotations (final ofsset) (not sure, ask
%Nicolas)
Si=Rz*S0;

% (ask Nicolas what's the purpose of these rotations. Why aren't we taking
% Rz into account)
Omega=qd(4)*x+qd(5)*Rx*y+qd(6)*Ry*z;
Omega_d=qdd(4)*x+qdd(5)*Rx*y+qdd(6)*Ry*z;

%Build the inertia matrix 
m=segment.m;
I=segment.inertia;
I(1,1)=I(1,1)+m*(Si(2)^2+Si(3)^2);
I(2,2)=I(2,2)+m*(Si(1)^2+Si(3)^2);
I(3,3)=I(3,3)+m*(Si(1)^2+Si(2)^2);
% why the formula isn't:
%   I(1,1)=I(1,1)+m*Si(1);
%   I(2,2)=I(2,2)+m*Si(2);
%   I(3,3)=I(3,3)+m*Si(3);

%Formulas of the Newten Euler equations seen in the AMORO lessons
Fi= Fj + m*g + m*qdd(1:3) + m*cross(Omega_d,S0) + m*mrot(Omega)*cross(Omega,S0);
Mi= Mj + cross(S0,m*g) + (Rz'*I*Rz)*Omega_d + m*cross(S0,qdd(1:3)) + mrot(Omega)*( Rz'*I*Rz * Omega );

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

%velocity of the CoM of the body
vm=qd(1:3)+cross(-S0,Omega);

%Energy of the CoM of the body
Ec=0.5*m*vm'*vm+0.5*Omega'*(Rz'*I*Rz)*Omega;
Ep=-m*g'*CoM;


end