%Made by Nicolas Testard if there is any question
clear; %close all;
%Only forces for now

%This seems to be the MAIN program
%The variable "Motion" descrives the motion that we want to perform with
%the simulator
%We currently have 3 possible motions:
%"slowArm", "mediumKick" and "maxJump"
Motion="slowArm";
%We execute the "Hanavan" function that loads the body parameters
Hanavan;
%we load the motion file associated to the filename choosen before
%It contains "qi" vectors which are unused, "Ji" vectors, and the "time" 
%array
load(Motion+"_q.mat")
motion.time=adapt_time(Motion,motion.time);

% Data from ground
load(Motion+"_ground.mat")


% Each Ji is a combination of vectors of dimension 6. We have as many Ji
% vectors as values inside the time array.

%Expressing body position at their CoM
%we convert the first 3 values of each J vector from mm to m
%and we convert the last 3 values of each J vector from º to rad
nb_step=length(motion.time);

for k=1:nb_step
    Head.pos(:,k)=CoM_pos_orientation(Head,motion.J4(:,k));
    U_Trunk.pos(:,k)=CoM_pos_orientation(U_Trunk,motion.J3(:,k));
    M_Trunk.pos(:,k)=CoM_pos_orientation(M_Trunk,motion.J2(:,k));
    L_Trunk.pos(:,k)=CoM_pos_orientation(L_Trunk,motion.J2(:,k));
    Upperarm.pos.R(:,k)=CoM_pos_orientation(Upperarm,motion.J8(:,k));
    Upperarm.pos.L(:,k)=CoM_pos_orientation(Upperarm,motion.J7(:,k));
    Forearm.pos.R(:,k)=CoM_pos_orientation(Forearm,motion.J10(:,k));
    Forearm.pos.L(:,k)=CoM_pos_orientation(Forearm,motion.J9(:,k));
    Hand.pos.R(:,k)=CoM_pos_orientation(Hand,motion.J12(:,k));
    Hand.pos.L(:,k)=CoM_pos_orientation(Hand,motion.J11(:,k));
    Thigh.pos.R(:,k)=CoM_pos_orientation(Thigh,motion.J16(:,k));
    Thigh.pos.L(:,k)=CoM_pos_orientation(Thigh,motion.J15(:,k));
    Shank.pos.R(:,k)=CoM_pos_orientation(Shank,motion.J18(:,k));
    Shank.pos.L(:,k)=CoM_pos_orientation(Shank,motion.J17(:,k));
    Foot.pos.R(:,k)=CoM_pos_orientation(Foot,motion.J20(:,k));
    Foot.pos.L(:,k)=CoM_pos_orientation(Foot,motion.J19(:,k));
end

%Here we compute the discrete time derivative and the discrete double time 
%derivative of the J vector using the time array for the increment
[Head.vel,Head.acc]=time_diff(Head.pos,motion.time);
[U_Trunk.vel,U_Trunk.acc]=time_diff(U_Trunk.pos,motion.time);
[M_Trunk.vel,M_Trunk.acc]=time_diff(M_Trunk.pos,motion.time);
[L_Trunk.vel,L_Trunk.acc]=time_diff(L_Trunk.pos,motion.time);
[Upperarm.vel.R,Upperarm.acc.R]=time_diff(Upperarm.pos.R,motion.time);
[Upperarm.vel.L,Upperarm.acc.L]=time_diff(Upperarm.pos.L,motion.time);
[Forearm.vel.R,Forearm.acc.R]=time_diff(Forearm.pos.R,motion.time);
[Forearm.vel.L,Forearm.acc.L]=time_diff(Forearm.pos.L,motion.time);
[Hand.vel.R,Hand.acc.R]=time_diff(Hand.pos.R,motion.time);
[Hand.vel.L,Hand.acc.L]=time_diff(Hand.pos.L,motion.time);
[Thigh.vel.R,Thigh.acc.R]=time_diff(Thigh.pos.R,motion.time);
[Thigh.vel.L,Thigh.acc.L]=time_diff(Thigh.pos.L,motion.time);
[Shank.vel.R,Shank.acc.R]=time_diff(Shank.pos.R,motion.time);
[Shank.vel.L,Shank.acc.L]=time_diff(Shank.pos.L,motion.time);
[Foot.vel.R,Foot.acc.R]=time_diff(Foot.pos.R,motion.time);
[Foot.vel.L,Foot.acc.L]=time_diff(Foot.pos.L,motion.time);


for k=1:6
    [Head.vel(k,:),Head.acc(k,:)]=rm_outliers(Head.vel(k,:),Head.acc(k,:));
    [U_Trunk.vel(k,:),U_Trunk.acc(k,:)]=rm_outliers(U_Trunk.vel(k,:),U_Trunk.acc(k,:));
    [M_Trunk.vel(k,:),M_Trunk.acc(k,:)]=rm_outliers(M_Trunk.vel(k,:),M_Trunk.acc(k,:));
    [L_Trunk.vel(k,:),L_Trunk.acc(k,:)]=rm_outliers(L_Trunk.vel(k,:),L_Trunk.acc(k,:));
    [Upperarm.vel.R(k,:),Upperarm.acc.R(k,:)]=rm_outliers(Upperarm.vel.R(k,:),Upperarm.acc.R(k,:));
    [Upperarm.vel.L(k,:),Upperarm.acc.L(k,:)]=rm_outliers(Upperarm.vel.L(k,:),Upperarm.acc.L(k,:));
    [Forearm.vel.R(k,:),Forearm.acc.R(k,:)]=rm_outliers(Forearm.vel.R(k,:),Forearm.acc.R(k,:));
    [Forearm.vel.L(k,:),Forearm.acc.L(k,:)]=rm_outliers(Forearm.vel.L(k,:),Forearm.acc.L(k,:));
    [Hand.vel.R(k,:),Hand.acc.R(k,:)]=rm_outliers(Hand.vel.R(k,:),Hand.acc.R(k,:));
    [Hand.vel.L(k,:),Hand.acc.L(k,:)]=rm_outliers(Hand.vel.L(k,:),Hand.acc.L(k,:));
    [Thigh.vel.R(k,:),Thigh.acc.R(k,:)]=rm_outliers(Thigh.vel.R(k,:),Thigh.acc.R(k,:));
    [Thigh.vel.L(k,:),Thigh.acc.L(k,:)]=rm_outliers(Thigh.vel.L(k,:),Thigh.acc.L(k,:));
    [Shank.vel.R(k,:),Shank.acc.R(k,:)]=rm_outliers(Shank.vel.R(k,:),Shank.acc.R(k,:));
    [Shank.vel.L(k,:),Shank.acc.L(k,:)]=rm_outliers(Shank.vel.L(k,:),Shank.acc.L(k,:));
    [Foot.vel.R(k,:),Foot.acc.R(k,:)]=rm_outliers(Foot.vel.R(k,:),Foot.acc.R(k,:));
    [Foot.vel.L(k,:),Foot.acc.L(k,:)]=rm_outliers(Foot.vel.L(k,:),Foot.acc.L(k,:));
end



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
   
   %R Hand
   Wrist=motion.J10(1:3,k)*1e-3;% wrist position
   [Fi,Ti,Ec,Ep]=NE_one_body(zeros(3,1),zeros(3,1),Hand,Hand.pos.R(:,k),Hand.vel.R(:,k),Hand.acc.R(:,k),Wrist);
   F_Wrist(:,k)=Fi;
   T_Wrist(:,k)=Ti;  
   F(:,k)=F(:,k)+F_Wrist(:,k);
   T(:,k)=T(:,k)+T_Wrist(:,k);
   %E(k)=E(k)+Ec; U(k)=U(k)+Ep;

   %R Forearm
   Elbow=motion.J8(1:3,k)*1e-3;% elbow position
   Fi=F_Wrist(:,k);
   Ti=T_Wrist(:,k)+cross(Wrist-Elbow,Fi); %expressing previous torques at the elbow point
   
   [Fi,Ti,Ec,Ep]=NE_one_body(Fi,Ti,Forearm,Forearm.pos.R(:,k),Forearm.vel.R(:,k),Forearm.acc.R(:,k),Elbow);
   F_Elbow(:,k)=Fi;
   T_Elbow(:,k)=Ti;
   F(:,k)=F(:,k)+F_Elbow(:,k);
   T(:,k)=T(:,k)+T_Elbow(:,k);
   %E(k)=E(k)+Ec; U(k)=U(k)+Ep;

   
   %R Upperarm
   Shoulder=motion.J6(1:3,k)*1e-3;% shoulder position
   Fi=F_Elbow(:,k);
   Ti=T_Elbow(:,k)+cross(Elbow-Shoulder,Fi); %expressing previous torques at the shoulder point
   
   [Fi,Ti,Ec,Ep]=NE_one_body(Fi,Ti,Upperarm,Upperarm.pos.R(:,k),Upperarm.vel.R(:,k),Upperarm.acc.R(:,k),Shoulder);
   F_Shoulder(:,k)=Fi;
   T_Shoulder(:,k)=Ti;
   F(:,k)=F(:,k)+F_Shoulder(:,k);
   T(:,k)=T(:,k)+T_Shoulder(:,k);
   %E(k)=E(k)+Ec; U(k)=U(k)+Ep;

 
end

%% Changing the frame
x=[1;0;0] ; y=[0;1;0] ; z=[0;0;1];
for k=1:nb_step
    %     theta_norm=norm(Forearm.pos.R(4:6));
    %     u=Forearm.pos.R(4:6)/theta_norm;
    %     R=rot_u(u,theta_norm);
    %     T_Wrist(:,k)=R'*T_Wrist(:,k);
    %
    %     theta_norm=norm(Upperarm.pos.R(4:6));
    %     u=Upperarm.pos.R(4:6)/theta_norm;
    %     R=rot_u(u,theta_norm);
    %     T_Elbow(:,k)=R'*T_Elbow(:,k);
    %
    %     theta_norm=norm(U_Trunk.pos(4:6));
    %     u=U_Trunk.pos(4:6)/theta_norm;
    %     R=rot_u(u,theta_norm);
    %     T_Shoulder(:,k)=R'*T_Shoulder(:,k);
    
    %Wrist
    Rx=rot_x(motion.J10(4,k)*pi/180);
    Ry=rot_x(motion.J10(4,k)*pi/180)*rot_y(motion.J10(5,k)*pi/180);
    Rz=rot_x(motion.J10(4,k)*pi/180)*rot_y(motion.J10(5,k)*pi/180)*rot_z(motion.J10(6,k)*pi/180);
    
    T1_Wrist=T_Wrist'*(Rx'*x);
    T2_Wrist=T_Wrist'*(Ry'*y);
    T3_Wrist=T_Wrist'*(Rz'*z);
    
    %Elbow
    Rx=rot_x(motion.J8(4,k)*pi/180);
    Ry=rot_x(motion.J8(4,k)*pi/180)*rot_y(motion.J8(5,k)*pi/180);
    Rz=rot_x(motion.J8(4,k)*pi/180)*rot_y(motion.J8(5,k)*pi/180)*rot_z(motion.J8(6,k)*pi/180);
    
    T1_Elbow=T_Elbow'*(Rx'*x);
    T2_Elbow=T_Elbow'*(Ry'*y);
    T3_Elbow=T_Elbow'*(Rz'*z);
    
    %Shoulder
    Rx=rot_x(motion.J3(4,k)*pi/180);
    Ry=rot_x(motion.J3(4,k)*pi/180)*rot_y(motion.J3(5,k)*pi/180);
    Rz=rot_x(motion.J3(4,k)*pi/180)*rot_y(motion.J3(5,k)*pi/180)*rot_z(motion.J3(6,k)*pi/180);
    
    T1_Shoulder=T_Shoulder'*(Rx'*x);
    T2_Shoulder=T_Shoulder'*(Ry'*y);
    T3_Shoulder=T_Shoulder'*(Rz'*z);
end

