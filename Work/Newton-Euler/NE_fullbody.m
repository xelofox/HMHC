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
[Head.velocity,Head.acceleration]=time_diff(Head.pos,motion.time);
[U_Trunk.velocity,U_Trunk.acceleration]=time_diff(U_Trunk.pos,motion.time);
[M_Trunk.velocity,M_Trunk.acceleration]=time_diff(M_Trunk.pos,motion.time);
[L_Trunk.velocity,L_Trunk.acceleration]=time_diff(L_Trunk.pos,motion.time);
[Upperarm.velocity.R,Upperarm.acceleration.R]=time_diff(Upperarm.pos.R,motion.time);
[Upperarm.velocity.L,Upperarm.acceleration.L]=time_diff(Upperarm.pos.L,motion.time);
[Forearm.velocity.R,Forearm.acceleration.R]=time_diff(Forearm.pos.R,motion.time);
[Forearm.velocity.L,Forearm.acceleration.L]=time_diff(Forearm.pos.L,motion.time);
[Hand.velocity.R,Hand.acceleration.R]=time_diff(Hand.pos.R,motion.time);
[Hand.velocity.L,Hand.acceleration.L]=time_diff(Hand.pos.L,motion.time);
[Thigh.velocity.R,Thigh.acceleration.R]=time_diff(Thigh.pos.R,motion.time);
[Thigh.velocity.L,Thigh.acceleration.L]=time_diff(Thigh.pos.L,motion.time);
[Shank.velocity.R,Shank.acceleration.R]=time_diff(Shank.pos.R,motion.time);
[Shank.velocity.L,Shank.acceleration.L]=time_diff(Shank.pos.L,motion.time);
[Foot.velocity.R,Foot.acceleration.R]=time_diff(Foot.pos.R,motion.time);
[Foot.velocity.L,Foot.acceleration.L]=time_diff(Foot.pos.L,motion.time);


F=zeros(3,nb_step);
T=F;

%Here we compute the reactions of each body part using the Newton-Euler
%equations
for k=1:nb_step
   %head
   [Fi,Ti,Ec,Ep]=NE_one_body(zeros(3,1),zeros(3,1),Head,Head.pos(:,k),Head.velocity(:,k),Head.acceleration(:,k),Head.pos(1:3,k));
   F(:,k)=F(:,k)+Fi;

end

% Filter
dt=motion.time(2)-motion.time(1);
[B,A] = butter(2,5*2*dt);
F_filtered=transpose(filtfilt(B,A,F'));

%plot
subplot(3,1,1)
hold off
plot(motion.time,F(1,:))
hold on
plot(motion.time,F_filtered(1,:))
title("Fx")
legend("raw","filtered")
xlabel("Time (s)")
ylabel("Force (N)")
subplot(3,1,2)
hold off
plot(motion.time,F(2,:))
hold on
plot(motion.time,F_filtered(2,:))
title("Fy")
legend("raw","filtered")
xlabel("Time (s)")
ylabel("Force (N)")
subplot(3,1,3)
hold off
plot(motion.time,F(3,:))
hold on
plot(motion.time,F_filtered(3,:))
title("Fz")
legend("raw","filtered")
xlabel("Time (s)")
ylabel("Force (N)")
