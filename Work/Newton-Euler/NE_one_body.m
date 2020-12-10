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
%norm returns the absolute value of a vector (pitagoras of the 3
%components)
theta_norm=norm(q(4:6));
%by doing this, we transform the rotations into a unitary vector and a
%multiplying factor
u=q(4:6)/theta_norm;
%and we define the rotation as that unitary vector and that scalar using
%this function:
R=rot_u(u,theta_norm)*R_ini(segment);

%S0 is the offset distance between our local frame, and its center of
%gravity
S0=(q(1:3)-Joint);
%Si is the same offset S0 in the body frame
Si=R'*S0;

%Build the inertia matrix (Huygens theorem)
m=segment.m;
I0=segment.inertia;
I0=I0+m*matrix_huygens(Si);

%Expressed inertia matrix in the world frame
Ii=R*I0*R';

%Velocity and acceleration of the joint of the body
Omega=qd(4:6);
vm=qd(1:3)+ cross(S0,Omega);
Omega_d=qdd(4:6);
vm_d=qdd(1:3)+cross(S0,Omega_d)+mrot(Omega)*cross(S0,Omega);

%Formulas of the Newten Euler equations seen in the AMORO lessons expressed
%in the world frame
Fi= Fj - m*g + m*vm_d + m*cross(Omega_d,S0) + m*cross(Omega,cross(Omega,S0));
Ti= Tj - cross(S0,m*g) + Ii*Omega_d + m*cross(S0,vm_d) + mrot(Omega)*( Ii * Omega );


%Energy of the CoM of the body
Ig=R*segment.inertia*R';
vg=qd(1:3);
Ec=0.5*m*vg'*vg+0.5*Omega'*Ig*Omega;
Ep=-m*g'*q(1:3);


end