%Made by Nicolas Testard if there is any question

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

% Each Ji is a combination of vectors of dimension 6. We have as many Ji
% vectors as values inside the time array.

%we convert the first 3 values of each J vector from mm to m
%and we convert the last 3 values of each J vector from º to rad
J1=[motion.J1(1:3,:)*1e-3;motion.J1(4:6,:)*pi/180];
J2=[motion.J2(1:3,:)*1e-3;motion.J2(4:6,:)*pi/180];
J3=[motion.J3(1:3,:)*1e-3;motion.J3(4:6,:)*pi/180];
J4=[motion.J4(1:3,:)*1e-3;motion.J4(4:6,:)*pi/180];
J5=[motion.J5(1:3,:)*1e-3;motion.J5(4:6,:)*pi/180];
J6=[motion.J6(1:3,:)*1e-3;motion.J6(4:6,:)*pi/180];
J7=[motion.J7(1:3,:)*1e-3;motion.J7(4:6,:)*pi/180];
J8=[motion.J8(1:3,:)*1e-3;motion.J8(4:6,:)*pi/180];
J9=[motion.J9(1:3,:)*1e-3;motion.J9(4:6,:)*pi/180];
J10=[motion.J10(1:3,:)*1e-3;motion.J10(4:6,:)*pi/180];
J11=[motion.J11(1:3,:)*1e-3;motion.J11(4:6,:)*pi/180];
J12=[motion.J12(1:3,:)*1e-3;motion.J12(4:6,:)*pi/180];
J13=[motion.J13(1:3,:)*1e-3;motion.J13(4:6,:)*pi/180];
J14=[motion.J14(1:3,:)*1e-3;motion.J14(4:6,:)*pi/180];
J15=[motion.J15(1:3,:)*1e-3;motion.J15(4:6,:)*pi/180];
J16=[motion.J16(1:3,:)*1e-3;motion.J16(4:6,:)*pi/180];
J17=[motion.J17(1:3,:)*1e-3;motion.J17(4:6,:)*pi/180];
J18=[motion.J18(1:3,:)*1e-3;motion.J18(4:6,:)*pi/180];
J19=[motion.J19(1:3,:)*1e-3;motion.J19(4:6,:)*pi/180];
J20=[motion.J20(1:3,:)*1e-3;motion.J20(4:6,:)*pi/180];

%Here we compute the discrete time derivative and the discrete double time 
%derivative of the J vector using the time array for the increment
[J1d,J1dd]=time_diff(J1,motion.time);
[J2d,J2dd]=time_diff(J2,motion.time);
[J3d,J3dd]=time_diff(J3,motion.time);
[J4d,J4dd]=time_diff(J4,motion.time);
[J5d,J5dd]=time_diff(J5,motion.time);
[J6d,J6dd]=time_diff(J6,motion.time);
[J7d,J7dd]=time_diff(J7,motion.time);
[J8d,J8dd]=time_diff(J8,motion.time);
[J9d,J9dd]=time_diff(J9,motion.time);
[J10d,J10dd]=time_diff(J10,motion.time);
[J11d,J11dd]=time_diff(J11,motion.time);
[J12d,J12dd]=time_diff(J12,motion.time);
[J13d,J13dd]=time_diff(J13,motion.time);
[J14d,J14dd]=time_diff(J14,motion.time);
[J15d,J15dd]=time_diff(J15,motion.time);
[J16d,J16dd]=time_diff(J16,motion.time);
[J17d,J17dd]=time_diff(J17,motion.time);
[J18d,J18dd]=time_diff(J18,motion.time);
[J19d,J19dd]=time_diff(J19,motion.time);
[J20d,J20dd]=time_diff(J20,motion.time);

F=zeros(3,size(J1d,2));
M=F;

%Here we compute the reactions of each body part using the Newton-Euler
%equations
for k=1:size(J1,2)
   %head
   [Ti,Fi,Mi,Ec,Ep]=NE_one_body(0,0,Head,J4(:,k),J4d(:,k),J4dd(:,k),J4(1:3,k),J4(1:3,k));
   F(:,k)=F(:,k)+Fi;
%    [X,Y,Z] = ellipsoid(0,0,0,Head.a,Head.b,Head.c); %Z=Z-Head.c;
%    [X,Y,Z]=trans_rot(X,Y,Z,motion.J4(:,k));
   
   %U trunk
   CoM=J3(1:3,k)-rot_x(J3(4,k))*rot_y(J3(5,k))*rot_z(J3(6,k))*(U_Trunk.L-U_Trunk.CoM);
   [Ti,Fi,Mi,Ec,Ep]=NE_one_body(0,0,U_Trunk,J4(:,k),J4d(:,k),J4dd(:,k),CoM,J4(1:3,k));
   F(:,k)=F(:,k)+Fi;
%    [X,Y,Z]=elliptical(U_Trunk.a0,U_Trunk.b0,U_Trunk.a1,U_Trunk.b1,U_Trunk.L); Z=Z-U_Trunk.L;
%    [X,Y,Z]=trans_rot(X,Y,Z,motion.J3(:,k));
   
%    %M_Trunk
%    [X,Y,Z]=elliptical(M_Trunk.a0,M_Trunk.b0,M_Trunk.a1,M_Trunk.b1,M_Trunk.L); Z=Z-M_Trunk.L;
%    [X,Y,Z]=trans_rot(X,Y,Z,motion.J2(:,k));
%    
%    %L_trunk
%    [X,Y,Z]=elliptical(L_Trunk.a0,L_Trunk.b0,L_Trunk.a1,L_Trunk.b1,L_Trunk.L);  %Z=Z-L_Trunk.L/2;
%    [X,Y,Z]=trans_rot(X,Y,Z,motion.J1(:,k));
%    
%    %R upper arm
%    [X,Y,Z]=elliptical(Upperarm.a0,Upperarm.b0,Upperarm.a1,Upperarm.b1,Upperarm.L);  Z=Z-Upperarm.L;
%    [X,Y,Z]=Rotation_solid(X,Y,Z,0,pi/2,0);
%    [X,Y,Z]=trans_rot(X,Y,Z,motion.J8(:,k));
%    
%    %L upper arm
%    [X,Y,Z]=elliptical(Upperarm.a0,Upperarm.b0,Upperarm.a1,Upperarm.b1,Upperarm.L);  Z=Z-Upperarm.L;
%    [X,Y,Z]=Rotation_solid(X,Y,Z,0,pi/2,0);
%    [X,Y,Z]=trans_rot(X,Y,Z,motion.J7(:,k));
% 
%    %R forearm
%    [X,Y,Z]=elliptical(Forearm.a0,Forearm.b0,Forearm.a1,Forearm.b1,Forearm.L);  Z=Z-Forearm.L;
%    [X,Y,Z]=Rotation_solid(X,Y,Z,0,pi/2,0);
%    [X,Y,Z]=trans_rot(X,Y,Z,motion.J10(:,k));
%    
%    %L forearm
%    [X,Y,Z]=elliptical(Forearm.a0,Forearm.b0,Forearm.a1,Forearm.b1,Forearm.L);  Z=Z-Forearm.L;
%    [X,Y,Z]=Rotation_solid(X,Y,Z,0,pi/2,0);
%    [X,Y,Z]=trans_rot(X,Y,Z,motion.J9(:,k));
%    
%    %R hand
%    [X,Y,Z] = ellipsoid(0,0,0,Hand.a,Hand.b,Hand.c); Z=Z-Hand.c;
%    [X,Y,Z]=Rotation_solid(X,Y,Z,0,pi/2,0);
%    [X,Y,Z]=trans_rot(X,Y,Z,motion.J12(:,k));
%    
%    %L hand
%    [X,Y,Z] = ellipsoid(0,0,0,Hand.a,Hand.b,Hand.c); Z=Z-Hand.c;
%    [X,Y,Z]=Rotation_solid(X,Y,Z,0,pi/2,0);
%    [X,Y,Z]=trans_rot(X,Y,Z,motion.J11(:,k));
%    
%    %R thigh
%    [X,Y,Z]=elliptical(Thigh.a0,Thigh.b0,Thigh.a1,Thigh.b1,Thigh.L);  %Z=Z-Thigh.L;
%    [X,Y,Z]=Rotation_solid(X,Y,Z,pi,0,0);
%    %[X,Y,Z]=trans_rot(X,Y,Z,motion.J14(:,k));
%    [X,Y,Z]=trans_rot2(X,Y,Z,motion.J14(:,k));
%    %[X,Y,Z]=trans_rot(X,Y,Z,[motion.J14(1:3,k);-motion.J14(4:6,k)]);
%    
%    %L thigh 
%    [X,Y,Z]=elliptical(Thigh.a0,Thigh.b0,Thigh.a1,Thigh.b1,Thigh.L);  %Z=Z-Thigh.L;
%    [X,Y,Z]=Rotation_solid(X,Y,Z,pi,0,0);
%    %[X,Y,Z]=trans_rot(X,Y,Z,motion.J13(:,k));
%    [X,Y,Z]=trans_rot2(X,Y,Z,motion.J13(:,k));
%    %[X,Y,Z]=trans_rot(X,Y,Z,[motion.J13(1:3,k);-motion.J13(4:6,k)]);
%    
%    %R shank
%    [X,Y,Z]=elliptical(Shank.a0,Shank.b0,Shank.a1,Shank.b1,Shank.L);  %Z=Z-Shank.L;
%    [X,Y,Z]=Rotation_solid(X,Y,Z,pi,0,0);
%    %[X,Y,Z]=trans_rot(X,Y,Z,motion.J16(:,k));
%    [X,Y,Z]=trans_rot2(X,Y,Z,motion.J16(:,k));
%    %[X,Y,Z]=trans_rot(X,Y,Z,[motion.J16(1:3,k);-motion.J16(4:6,k)]);
%    
%    %L shank 
%    [X,Y,Z]=elliptical(Shank.a0,Shank.b0,Shank.a1,Shank.b1,Shank.L);  %Z=Z-Shank.L;
%    [X,Y,Z]=Rotation_solid(X,Y,Z,pi,0,0);
%    %[X,Y,Z]=trans_rot(X,Y,Z,motion.J15(:,k));
%    [X,Y,Z]=trans_rot2(X,Y,Z,motion.J15(:,k));
%    %[X,Y,Z]=trans_rot(X,Y,Z,[motion.J15(1:3,k);-motion.J15(4:6,k)]);
%    
%    %R foot
%    [X,Y,Z]=elliptical(Foot.a0,Foot.b0,Foot.a1,Foot.b1,Foot.L);  %Z=Z-Foot.L;
%    [X,Y,Z]=Rotation_solid(X,Y,Z,pi/2,0,0);
%    %[X,Y,Z]=trans_rot(X,Y,Z,motion.J18(:,k));
%    [X,Y,Z]=trans_rot2(X,Y,Z,motion.J18(:,k));
%    %[X,Y,Z]=trans_rot(X,Y,Z,[motion.J18(1:3,k);-motion.J18(4:6,k)]);
%    
%    %L foot 
%    [X,Y,Z]=elliptical(Foot.a0,Foot.b0,Foot.a1,Foot.b1,Foot.L);  %Z=Z-Foot.L;
%    [X,Y,Z]=Rotation_solid(X,Y,Z,pi/2,0,0);
%    %[X,Y,Z]=trans_rot(X,Y,Z,motion.J17(:,k));
%    [X,Y,Z]=trans_rot2(X,Y,Z,motion.J17(:,k));
%    %[X,Y,Z]=trans_rot(X,Y,Z,[motion.J17(1:3,k);-motion.J17(4:6,k)]);
end




% t1=10.8; t2=11.2; t1=0; t2=12; 
% t=motion.time;
% index=find(((t>t1).*(t<t2)));
% i1=index(1);i2=index(end);
% pos=motion.J16(6,:);
% [vel,acc]=time_diff(pos,t);
% subplot(1,3,1)
% plot(t,pos,'-o')
% ylabel("Angle (°)")
% xlabel("Time (s)")
% title("Angle")
% axis([t1 t2 min(pos(i1:i2))*1.1 max(pos(i1:i2))*1.1])
% subplot(1,3,2)
% plot(t,vel,'-o')
% ylabel("Velocity (°/s)")
% xlabel("Time (s)")
% axis([t1 t2 min(vel(i1:i2))*1.1 max(vel(i1:i2))*1.1+1000])
% title("Velocity")
% subplot(1,3,3)
% plot(t,acc,'-o')
% ylabel("Acceleration (°/S^2)")
% xlabel("Time (s)")
% axis([t1 t2 min(acc(i1:i2))*1.1 max(acc(i1:i2))*1.1])
% title("Acceleration")

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

