function [pos,vel,acc]=kinematic(segment,t,q)

nb_step=length(t);

Euler_angle=q(4:6,:)*pi/180;
pos=zeros(6,nb_step);
for k=1:nb_step
    pos(:,k)=CoM_pos_orientation(segment,q(:,k));
end




[Omega,Omega_d]=time_diff_angle(Euler_angle,t);
 

%% Computation of the marker vel and acc
marker_pos=q(1:3,:)*1e-3;
[marker_vel,marker_acc]=time_diff(marker_pos,t);
%marker_vel=marker_vel*0;
%marker_acc=marker_acc*0;

%% Computation of the CoM vel and acc

CoM_vel=zeros(3,nb_step); CoM_acc=CoM_vel;

for k=1:nb_step
    CoM_pos=pos(1:3,k);
    S=CoM_pos-marker_pos(1:3,k);
    CoM_vel(:,k)=marker_vel(:,k)+cross(Omega(:,k),S);
    CoM_acc(:,k)=marker_acc(:,k)+cross(Omega_d(:,k),S)+mrot(Omega(:,k))*cross(Omega(:,k),S);
end

%CoM_vel=zeros(3,nb_step);CoM_acc=CoM_vel;
%[CoM_vel,CoM_acc]=time_diff(pos(1:3,:),t);
vel=[CoM_vel;Omega];
acc=[CoM_acc;Omega_d];

segment.pos=pos;
segment.vel=vel;
segment.acc=acc;


end