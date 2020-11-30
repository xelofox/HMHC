%Made by Nicolas Testard if there is any question
%Inputs
%   Fj = External Force applied to the body
%   Tj = External Torque applied to the body
%   segment = Name of the body part (struct variable)
%   q = vector of positions (CoM)
%   qd = vector of velocities (CoM)
%   qdd = vector of accelerations (CoM)
%   Joint = Main frame of the body

%Outputs
%   Fi = Force of the main joint of the particular body part
%   Ti = Torque of the main joint of the particular body part
%   Ec = Kinetic Energy of the CoM of the body
%   Ep = Potential Energy of the CoM of the body

function [Fi,Ti,Ec,Ep]=NE_one_body(Fj,Tj,segment,q,qd,qdd,Joint)
x=[1;0;0] ; y=[0;1;0] ; z=[0;0;1];
g=-9.81*z;

%The three main rotations of the body among the local x, y and z angles
%relying on the 3 last values imported from each Ji vector
theta_norm=norm(q(4:6));
u=q(4:6)/theta_norm;
R=rot_u(u,theta_norm);

%S0 is the offset distance between our local frame, and its center of
%gravity
S0=(q(1:3)-Joint);
%Si is the same offset S0 in the body frame
Si=R*S0;

%Build the inertia matrix (Huygens theorem)
m=segment.m;
I0=segment.inertia;
I0(1,1)=I0(1,1)+m*(Si(2)^2+Si(3)^2);
I0(2,2)=I0(2,2)+m*(Si(1)^2+Si(3)^2);
I0(3,3)=I0(3,3)+m*(Si(1)^2+Si(2)^2);

%Expressed inertia matrix in the world frame
Ii=R'*I0*R;

%Velocity and acceleration of the CoM of the body
vm=qd(1:3);
Omega=qd(4:6);
vm_d=qdd(1:3);
Omega_d=qdd(4:6);

%Formulas of the Newten Euler equations seen in the AMORO lessons expressed
%in the world frame
Fi= Fj - m*g + m*vm_d + m*cross(Omega_d,S0) + m*mrot(Omega)*cross(Omega,S0);
Ti= Tj - cross(S0,m*g) + Ii*Omega_d + m*cross(S0,vm_d) + mrot(Omega)*( Ii * Omega );


%Energy of the CoM of the body
Ec=0.5*m*vm'*vm+0.5*Omega'*Ii*Omega;
Ep=-m*g'*q(1:3);


end