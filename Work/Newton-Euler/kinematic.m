function [pos,vel,acc]=kinematic(segment,t,q)

nb_step=length(t);
x=[1;0;0] ; y=[0;1;0] ; z=[0;0;1];


Euler_angle=q(4:6,:)*pi/180;
pos=zeros(6,nb_step);
for k=1:nb_step
    pos(:,k)=CoM_pos_orientation(segment,q(:,k));
end
%% Computation of the derivative of euler angle
Euler_vel=zeros(3,nb_step);
angle_step=150; %degree

% for i=1:3
%     k=1;
%     while k<=nb_step
%         if (k==1)
%             Euler_vel(i,k)=(Euler_angle(i,k+1)-Euler_angle(i,k)) / (t(k+1)-t(k));
%             
%         elseif (k==nb_step)
%             Euler_vel(i,k)=(Euler_angle(i,k)-Euler_angle(i,k-1)) / (t(k)-t(k-1));
%             
%         elseif ( abs( q(i+3,k)-q(i+3,k-1) ) > angle_step ) % previous point far
%             Euler_vel(i,k)=(Euler_angle(i,k+1)-Euler_angle(i,k)) / (t(k+1)-t(k));
%             
%         elseif ( abs( q(i+3,k+1)-q(i+3,k) ) > angle_step ) %next point far
%             Euler_vel(i,k)=(Euler_angle(i,k)-Euler_angle(i,k-1)) / (t(k)-t(k-1));
%             
%              if (k+2<nb_step)||( abs( q(i+3,k+2)-q(i+3,k+1) )> angle_step) % the next point is following by a second gap
%                 Euler_vel(i,k+1)=(Euler_angle(i,k+2)-Euler_angle(i,k)) / (t(k+2)-t(k));
%                 k=k+1;
%             end
%             
%         else
%             Euler_vel(i,k)=(Euler_angle(i,k+1)-Euler_angle(i,k-1)) / (t(k+1)-t(k-1));         
%         end
%         k=k+1;
%     end
% end

Euler_vel=zeros(3,nb_step);
angle_step=150*pi/180; %degree

for i=1:3
    k=1;
    while k<=nb_step
        if (k==1)
            Euler_vel(i,k)=(Euler_angle(i,k+1)-Euler_angle(i,k)) / (t(k+1)-t(k));
            
        elseif (k==nb_step)
            Euler_vel(i,k)=(Euler_angle(i,k)-Euler_angle(i,k-1)) / (t(k)-t(k-1));
            
        elseif ( abs( Euler_angle(i,k)-Euler_angle(i,k-1) ) > angle_step ) % previous point far
            Euler_vel(i,k)=(Euler_angle(i,k+1)-Euler_angle(i,k)) / (t(k+1)-t(k));
            
        elseif ( abs( Euler_angle(i,k+1)-Euler_angle(i,k) ) > angle_step ) %next point far
            Euler_vel(i,k)=(Euler_angle(i,k)-Euler_angle(i,k-1)) / (t(k)-t(k-1));
            
             while (k+2<=nb_step)&&( abs( Euler_angle(i,k+2)-Euler_angle(i,k+1) )> angle_step) % the next points is following by a second gap
                Euler_vel(i,k+1)=(Euler_angle(i,k+2)-Euler_angle(i,k)) / (t(k+2)-t(k));
                k=k+1;
            end
            
        else
            Euler_vel(i,k)=(Euler_angle(i,k+1)-Euler_angle(i,k-1)) / (t(k+1)-t(k-1));         
        end
        k=k+1;
    end
end

%% Computation of the angular velocity
Omega=zeros(3,nb_step);
for k=1:nb_step
    Rx=rot_x(q(4,k)*pi/180);
    Ry=rot_x(q(4,k)*pi/180)*rot_y(q(5,k)*pi/180);
    %Rz=rot_x(q(4,k)*pi/180)*rot_y(q(5,k)*pi/180)*rot_z(q(6,k)*pi/180);
    Omega(:,k)=Euler_vel(1,k)*x + Euler_vel(2,k)*Rx*y + Euler_vel(3,k)*Ry*z;
end

%% Computation of the secod derivative of euler angle
% Euler_acc=zeros(3,nb_step);
% for k=1:nb_step
%     for i=1:3
%         if (k==1)
%             Euler_acc(i,k)=(Euler_vel(i,k+1)-Euler_vel(i,k)) / (t(k+1)-t(k));
%         elseif (k==nb_step)
%             Euler_acc(i,k)=(Euler_vel(i,k)-Euler_vel(i,k-1)) / (t(k)-t(k-1));
%         else
%             Euler_acc(i,k)=(Euler_vel(i,k+1)-Euler_vel(i,k-1)) / (t(k+1)-t(k-1));
%         end
%     end
% end

%% Computation of the angular acceleration
Omega_d=zeros(3,nb_step);
% for k=1:nb_step
%     
%     Rx=rot_x(q(4,k)*pi/180);
%     Ry=rot_x(q(4,k)*pi/180)*rot_y(q(5,k)*pi/180);
%     %Rz=rot_x(q(4,k)*pi/180)*rot_y(q(5,k)*pi/180)*rot_z(q(6,k)*pi/180);
%     
%     Rx_diff=rot_x(q(4,k)*pi/180 + pi/2) * Euler_vel(1,k);
%     Ry_diff=rot_x(q(4,k)*pi/180 + pi/2)*rot_y(q(5,k)*pi/180) * Euler_vel(1,k)...
%         + rot_x(q(4,k)*pi/180)*rot_y(q(5,k)*pi/180 + pi/2 ) * Euler_vel(2,k);
%     %Rz_diff=rot_x(q(4,k)*pi/180)*rot_y(q(5,k)*pi/180)*rot_z(q(6,k)*pi/180); %not done yet
%     
%     Omega_d(:,k)=Euler_acc(1,k)*x + Euler_acc(2,k)*Rx*y + Euler_acc(3,k)*Ry*z ...
%         + Euler_vel(2,k)*Rx_diff*y + Euler_vel(3,k)*Ry_diff*z;
% end

for k=1:nb_step
    if k==1
        Omega_d(:,k)=(Omega(:,k+1)-Omega(:,k)) / (t(k+1)-t(k));
    elseif k==nb_step
        Omega_d(:,k)=(Omega(:,k)-Omega(:,k-1)) / (t(k)-t(k-1));
    else
        Omega_d(:,k)=(Omega(:,k+1)-Omega(:,k-1)) / (t(k+1)-t(k-1));
    end
end

%% Computation of the marker vel and acc
marker_pos=q(1:3,:)*1e-3;
[marker_vel,marker_acc]=time_diff(marker_pos,t);


%% Computation of the CoM vel and acc
[Omega,Omega_d]=rm_outliers(Omega,Omega_d);

CoM_vel=zeros(3,nb_step); CoM_acc=CoM_vel;
% CoM_pos=pos;
% [CoM_vel,CoM_acc]=time_diff(CoM_pos,t);
% [CoM_vel,CoM_acc]=rm_outliers(CoM_vel,CoM_acc);
for k=1:nb_step
    CoM_pos=pos(1:3,k);
    S=CoM_pos-marker_pos(1:3,k);
    CoM_vel(:,k)=marker_vel(:,k)+cross(Omega(:,k),S);
    CoM_acc(:,k)=marker_acc(:,k)+cross(Omega_d(:,k),S)+mrot(Omega(:,k))*cross(Omega(:,k),S);
end

vel=[CoM_vel;Omega];
acc=[CoM_acc;Omega_d];

segment.pos=pos;
segment.vel=vel;
segment.acc=acc;


end