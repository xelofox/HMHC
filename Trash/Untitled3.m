Motion="slowArm";
%We execute the "Hanavan" function that loads the body parameters
Hanavan;
%we load the motion file associated to the filename choosen before
%It contains "qi" vectors which are unused, "Ji" vectors, and the "time" 
%array
load(Motion+"_q.mat")
x=[1;0;0] ; y=[0;1;0] ; z=[0;0;1];

J4=[motion.J4(1:3,100);motion.J4(4:6,100)];
J4b=CoM_pos_orientation(Head,J4);
R1=rot_x(J4(4)*pi/180)*rot_y(J4(5)*pi/180)*rot_z(J4(6)*pi/180)
%R1=rot_z(J4(6)*pi/180)*rot_y(J4(5)*pi/180)*rot_x(J4(4)*pi/180);
theta_norm=norm(J4b(4:6));
u=J4b(4:6)/theta_norm;
R2=rot_u(u,theta_norm)