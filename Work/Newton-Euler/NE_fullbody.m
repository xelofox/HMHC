%Made by Nicolas Testard if there is any question
clear; %close all;
%Only forces for now

%This seems to be the MAIN program
%The variable "Motion" descrives the motion that we want to perform with
%the simulator
%We currently have 3 possible motions:
%"slowArm", "mediumKick" and "maxJump"
Motion="jumpFeetUp";
%We execute the "Hanavan" function that loads the body parameters
Hanavan;
%we load the motion file associated to the filename choosen before
%It contains "qi" vectors which are unused, "Ji" vectors, and the "time" 
%array
load(Motion+"_q.mat")
motion.time=adapt_time(Motion,motion.time);
%motion.time=motion.time-motion.time(1);
% Data from ground
load(Motion+"_ground.mat")


% Each Ji is a combination of vectors of dimension 6. We have as many Ji
% vectors as values inside the time array.

%Expressing body position at their CoM
%we convert the first 3 values of each J vector from mm to m
%and we convert the last 3 values of each J vector from º to rad
nb_step=length(motion.time);

% The function CoM_pos_orientation returs us with the position and the
% orientation of the CoM of a segment


%Here we compute the discrete time derivative and the discrete double time 
%derivative of the J vector using the time array for the increment


% The kinematic function returns us the angular position, angular velocity 
% and angular orientation of the CoM of the body
[Head.pos,Head.vel,Head.acc]=kinematic(Head,motion.time,motion.J4);
[U_Trunk.pos,U_Trunk.vel,U_Trunk.acc]=kinematic(U_Trunk,motion.time,motion.J3);
[M_Trunk.pos,M_Trunk.vel,M_Trunk.acc]=kinematic(M_Trunk,motion.time,motion.J2);
[L_Trunk.pos,L_Trunk.vel,L_Trunk.acc]=kinematic(L_Trunk,motion.time,motion.J2);
[Upperarm.pos.R,Upperarm.vel.R,Upperarm.acc.R]=kinematic(Upperarm,motion.time,motion.J8);
[Upperarm.pos.L,Upperarm.vel.L,Upperarm.acc.L]=kinematic(Upperarm,motion.time,motion.J7);
[Forearm.pos.R,Forearm.vel.R,Forearm.acc.R]=kinematic(Forearm,motion.time,motion.J10);
[Forearm.pos.L,Forearm.vel.L,Forearm.acc.L]=kinematic(Forearm,motion.time,motion.J9);
[Hand.pos.R,Hand.vel.R,Hand.acc.R]=kinematic(Hand,motion.time,motion.J12);
[Hand.pos.L,Hand.vel.L,Hand.acc.L]=kinematic(Hand,motion.time,motion.J11);
[Thigh.pos.R,Thigh.vel.R,Thigh.acc.R]=kinematic(Thigh,motion.time,motion.J16);
[Thigh.pos.L,Thigh.vel.L,Thigh.acc.L]=kinematic(Thigh,motion.time,motion.J15);
[Shank.pos.R,Shank.vel.R,Shank.acc.R]=kinematic(Shank,motion.time,motion.J18);
[Shank.pos.L,Shank.vel.L,Shank.acc.L]=kinematic(Shank,motion.time,motion.J17);
[Foot.pos.R,Foot.vel.R,Foot.acc.R]=kinematic(Foot,motion.time,motion.J20);
[Foot.pos.L,Foot.vel.L,Foot.acc.L]=kinematic(Foot,motion.time,motion.J19);


F=zeros(3,nb_step);
T=F;
E=zeros(1,nb_step); U=E;
%Here we compute the reactions of each body part using the Newton-Euler
%equations
for k=1:nb_step
   %Head
   [Fi,Ti,Ec,Ep]=NE_one_body(zeros(3,1),zeros(3,1),Head,Head.pos(:,k),Head.vel(:,k),Head.acc(:,k),Head.pos(1:3,k));
   F(:,k)=F(:,k)+Fi;
   T(:,k)=T(:,k)+Ti+cross(Head.pos(1:3,k),Fi);
   E(k)=E(k)+Ec; U(k)=U(k)+Ep;

   %U_Trunk
   [Fi,Ti,Ec,Ep]=NE_one_body(zeros(3,1),zeros(3,1),U_Trunk,U_Trunk.pos(:,k),U_Trunk.vel(:,k),U_Trunk.acc(:,k),U_Trunk.pos(1:3,k));
   F(:,k)=F(:,k)+Fi;
   T(:,k)=T(:,k)+Ti+cross(U_Trunk.pos(1:3,k),Fi);
   E(k)=E(k)+Ec; U(k)=U(k)+Ep;

   %M_Trunk
   [Fi,Ti,Ec,Ep]=NE_one_body(zeros(3,1),zeros(3,1),M_Trunk,M_Trunk.pos(:,k),M_Trunk.vel(:,k),M_Trunk.acc(:,k),M_Trunk.pos(1:3,k));
   F(:,k)=F(:,k)+Fi;
   T(:,k)=T(:,k)+Ti+cross(M_Trunk.pos(1:3,k),Fi);
   E(k)=E(k)+Ec; U(k)=U(k)+Ep;

   %L_Trunk
   [Fi,Ti,Ec,Ep]=NE_one_body(zeros(3,1),zeros(3,1),L_Trunk,L_Trunk.pos(:,k),L_Trunk.vel(:,k),L_Trunk.acc(:,k),L_Trunk.pos(1:3,k));
   F(:,k)=F(:,k)+Fi;
   T(:,k)=T(:,k)+Ti+cross(L_Trunk.pos(1:3,k),Fi);
   E(k)=E(k)+Ec; U(k)=U(k)+Ep;

   %R Upperarm
   [Fi,Ti,Ec,Ep]=NE_one_body(zeros(3,1),zeros(3,1),Upperarm,Upperarm.pos.R(:,k),Upperarm.vel.R(:,k),Upperarm.acc.R(:,k),Upperarm.pos.R(1:3,k));
   F(:,k)=F(:,k)+Fi;
   T(:,k)=T(:,k)+Ti+cross(Upperarm.pos.R(1:3,k),Fi);
   E(k)=E(k)+Ec; U(k)=U(k)+Ep;

   %L Upperarm
   [Fi,Ti,Ec,Ep]=NE_one_body(zeros(3,1),zeros(3,1),Upperarm,Upperarm.pos.L(:,k),Upperarm.vel.L(:,k),Upperarm.acc.L(:,k),Upperarm.pos.L(1:3,k));
   F(:,k)=F(:,k)+Fi;
   T(:,k)=T(:,k)+Ti+cross(Upperarm.pos.L(1:3,k),Fi);
   E(k)=E(k)+Ec; U(k)=U(k)+Ep;

   %R Forearm
   [Fi,Ti,Ec,Ep]=NE_one_body(zeros(3,1),zeros(3,1),Forearm,Forearm.pos.R(:,k),Forearm.vel.R(:,k),Forearm.acc.R(:,k),Forearm.pos.R(1:3,k));
   F(:,k)=F(:,k)+Fi;
   T(:,k)=T(:,k)+Ti+cross(Forearm.pos.R(1:3,k),Fi);
   E(k)=E(k)+Ec; U(k)=U(k)+Ep;

   %L Forearm
   [Fi,Ti,Ec,Ep]=NE_one_body(zeros(3,1),zeros(3,1),Forearm,Forearm.pos.L(:,k),Forearm.vel.L(:,k),Forearm.acc.L(:,k),Forearm.pos.L(1:3,k));
   F(:,k)=F(:,k)+Fi;
   T(:,k)=T(:,k)+Ti+cross(Forearm.pos.L(1:3,k),Fi);
   E(k)=E(k)+Ec; U(k)=U(k)+Ep;

   %R Hand
   [Fi,Ti,Ec,Ep]=NE_one_body(zeros(3,1),zeros(3,1),Hand,Hand.pos.R(:,k),Hand.vel.R(:,k),Hand.acc.R(:,k),Hand.pos.R(1:3,k));
   F(:,k)=F(:,k)+Fi;
   T(:,k)=T(:,k)+Ti+cross(Hand.pos.R(1:3,k),Fi);
   E(k)=E(k)+Ec; U(k)=U(k)+Ep;

   %L Hand
   [Fi,Ti,Ec,Ep]=NE_one_body(zeros(3,1),zeros(3,1),Hand,Hand.pos.L(:,k),Hand.vel.L(:,k),Hand.acc.L(:,k),Hand.pos.L(1:3,k));
   F(:,k)=F(:,k)+Fi;
   T(:,k)=T(:,k)+Ti+cross(Hand.pos.L(1:3,k),Fi);
   E(k)=E(k)+Ec; U(k)=U(k)+Ep;

   %R Thigh
   [Fi,Ti,Ec,Ep]=NE_one_body(zeros(3,1),zeros(3,1),Thigh,Thigh.pos.R(:,k),Thigh.vel.R(:,k),Thigh.acc.R(:,k),Thigh.pos.R(1:3,k));
   F(:,k)=F(:,k)+Fi;
   T(:,k)=T(:,k)+Ti+cross(Thigh.pos.R(1:3,k),Fi);
   E(k)=E(k)+Ec; U(k)=U(k)+Ep;

   %L Thigh
   [Fi,Ti,Ec,Ep]=NE_one_body(zeros(3,1),zeros(3,1),Thigh,Thigh.pos.L(:,k),Thigh.vel.L(:,k),Thigh.acc.L(:,k),Thigh.pos.L(1:3,k));
   F(:,k)=F(:,k)+Fi;
   T(:,k)=T(:,k)+Ti+cross(Thigh.pos.L(1:3,k),Fi);
   E(k)=E(k)+Ec; U(k)=U(k)+Ep;

   %R Shank
   [Fi,Ti,Ec,Ep]=NE_one_body(zeros(3,1),zeros(3,1),Shank,Shank.pos.R(:,k),Shank.vel.R(:,k),Shank.acc.R(:,k),Shank.pos.R(1:3,k));
   F(:,k)=F(:,k)+Fi;
   T(:,k)=T(:,k)+Ti+cross(Shank.pos.R(1:3,k),Fi);
   E(k)=E(k)+Ec; U(k)=U(k)+Ep;

   %L Shank
   [Fi,Ti,Ec,Ep]=NE_one_body(zeros(3,1),zeros(3,1),Shank,Shank.pos.L(:,k),Shank.vel.L(:,k),Shank.acc.L(:,k),Shank.pos.L(1:3,k));
   F(:,k)=F(:,k)+Fi;
   T(:,k)=T(:,k)+Ti+cross(Shank.pos.L(1:3,k),Fi);
   E(k)=E(k)+Ec; U(k)=U(k)+Ep;

   %R Foot
   [Fi,Ti,Ec,Ep]=NE_one_body(zeros(3,1),zeros(3,1),Foot,Foot.pos.R(:,k),Foot.vel.R(:,k),Foot.acc.R(:,k),Foot.pos.R(1:3,k));
   F(:,k)=F(:,k)+Fi;
   T(:,k)=T(:,k)+Ti+cross(Foot.pos.R(1:3,k),Fi);
   E(k)=E(k)+Ec; U(k)=U(k)+Ep;

   %L Foot
   [Fi,Ti,Ec,Ep]=NE_one_body(zeros(3,1),zeros(3,1),Foot,Foot.pos.L(:,k),Foot.vel.L(:,k),Foot.acc.L(:,k),Foot.pos.L(1:3,k));
   F(:,k)=F(:,k)+Fi;
   T(:,k)=T(:,k)+Ti+cross(Foot.pos.L(1:3,k),Fi);
   E(k)=E(k)+Ec; U(k)=U(k)+Ep;

end



%% Comparison with the data
% The function plot_comparison compares the plots between the ground
% reaction efforts computed from the motion capture and the ones
%  obtained from themeasurements of the force-plate


% Rotation of the frame to alignm the two reference frame orientation
for k=1:nb_step
   F(:,k)= rot_z(pi/2)*F(:,k);
   T(:,k)= rot_z(pi/2)*T(:,k);
end

% Computation of the CoP
CoP=zeros(3,nb_step);
for k=1:nb_step
    CoP(1,k)=-T(2,k)/F(3,k);
    CoP(2,k)=T(1,k)/F(3,k);
    T_CoP(:,k)=T(:,k)-cross(CoP(:,k),F(:,k));
end

for k=1:length(ground.CoPx)
    ground.T_CoP(:,k)=[ground.Mx(k); ground.My(k);ground.Mz(k)]+...
        -cross([ground.CoPx(k); ground.CoPy(k);0],[ground.Fx(k); ground.Fy(k);ground.Fz(k)]);
end

% dt=motion.time(2)-motion.time(1);
% [B,A] = butter(2,5*2*dt);
% T_CoP(3,:)=filtfilt(B,A,T_CoP(3,:));



% figure
% plot_comparison(ground.time,[ground.Fx';ground.Fy';ground.Fz';ground.T_CoP],...
%     motion.time,[F_filtered;T_CoP],["Force plate";"NE algo"])
% plot_comparison2(ground.time,[ground.Fx';ground.Fy';ground.Fz';ground.T_CoP],...
%     motion.time,[F;T_CoP],["Force plate";"NE algo"])


%% Energy
%figure
% [B,A] = butter(2,5*2*dt);
% E=filtfilt(B,A,E);
yyaxis left
plot(motion.time, E+U,'displayname',"Mechanical E");
hold on
plot(motion.time, U,'displayname',"Potential E");
ylabel("Energy (J)")
yyaxis right
plot(motion.time, E,'displayname',"Kinetic E");
xlabel("Time (s)")
ylabel("Energy (J)")
grid on
title(Motion)
legend show


