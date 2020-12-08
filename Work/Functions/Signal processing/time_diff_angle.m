function [Omega,Omega_d]=time_diff_angle(Euler_angle,t)

nb_step=length(t);
Euler_vel=zeros(3,nb_step);
angle_step=150*pi/180; %degree

%% Computation of the derivative of euler angle


for i=1:3
    k=1;
    while k<=nb_step
        if (k==1)
            Euler_vel(i,k)=(Euler_angle(i,k+1)-Euler_angle(i,k)) / (t(k+1)-t(k));
            
        elseif (k==nb_step)
            Euler_vel(i,k)=(Euler_angle(i,k)-Euler_angle(i,k-1)) / (t(k)-t(k-1));
            
        elseif ( abs( Euler_angle(i,k)-Euler_angle(i,k-1) ) > angle_step ) % previous point far
            Euler_vel(i,k)=(Euler_angle(i,k+1)-Euler_angle(i,k-1) - 2*pi*sign(Euler_angle(i,k)-Euler_angle(i,k-1) ) ) / (t(k+1)-t(k-1));
            
        elseif ( abs( Euler_angle(i,k+1)-Euler_angle(i,k) ) > angle_step ) %next point far
            Euler_vel(i,k)=(Euler_angle(i,k+1)-Euler_angle(i,k-1) - 2*pi*sign( Euler_angle(i,k+1)-Euler_angle(i,k)) ) / (t(k+1)-t(k-1));
            
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

dt=t(2)-t(1);
Euler_vel=signal_filter(Euler_vel,dt);

%% Computation of the angular velocity
x=[1;0;0] ; y=[0;1;0] ; z=[0;0;1];
Omega=zeros(3,nb_step);
for k=1:nb_step
    Rx=rot_x(Euler_angle(1,k));
    Ry=rot_x(Euler_angle(1,k))*rot_y(Euler_angle(2,k));
    %Rz=rot_x(q(4,k)*pi/180)*rot_y(q(5,k)*pi/180)*rot_z(q(6,k)*pi/180);
    
    %Rx=rot_x(q(4,k)*pi/180)*R_ini(segment);
    %Ry=rot_x(q(4,k)*pi/180)*rot_y(q(5,k)*pi/180)*R_ini(segment);
    
    Omega(:,k)=Euler_vel(1,k)*x + Euler_vel(2,k)*Rx*y + Euler_vel(3,k)*Ry*z;
end

%% Computation of the angular acceleration
Omega_d=zeros(3,nb_step);
for k=1:nb_step
    if k==1
        Omega_d(:,k)=(Omega(:,k+1)-Omega(:,k)) / (t(k+1)-t(k));
    elseif k==nb_step
        Omega_d(:,k)=(Omega(:,k)-Omega(:,k-1)) / (t(k)-t(k-1));
    else
        Omega_d(:,k)=(Omega(:,k+1)-Omega(:,k-1)) / (t(k+1)-t(k-1));
    end
end

%Omega_d=signal_filter(Omega_d,dt);
    
end
    
    
    
    
    
    
    
    
% for i=1:3
%     k=1;
%     while k<=nb_step
%         if (k==1)
%             Euler_vel(i,k)=(Euler_angle(i,k+1)-Euler_angle(i,k)) / (t(k+1)-t(k));
%             
%         elseif (k==nb_step)
%             Euler_vel(i,k)=(Euler_angle(i,k)-Euler_angle(i,k-1)) / (t(k)-t(k-1));
%             
%         elseif ( abs( Euler_angle(i,k)-Euler_angle(i,k-1) ) > angle_step ) % previous point far
%             Euler_vel(i,k)=(Euler_angle(i,k+1)-Euler_angle(i,k)) / (t(k+1)-t(k));
%             
%         elseif ( abs( Euler_angle(i,k+1)-Euler_angle(i,k) ) > angle_step ) %next point far
%             Euler_vel(i,k)=(Euler_angle(i,k)-Euler_angle(i,k-1)) / (t(k)-t(k-1));
%             
%             while (k+2<=nb_step)&&( abs( Euler_angle(i,k+2)-Euler_angle(i,k+1) )> angle_step) % the next points is following by a second gap
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

    


% quat=zeros(4,nb_step); quat_d=quat;
% for k=1:nb_step
%     quat(:,k)=transpose(rotm2quat( rot_x(Euler_angle(1,k))*rot_y(Euler_angle(2,k))*rot_z(Euler_angle(3,k)) ));
% end
% 
% for k=1:nb_step
%     if (k==1)
%         quat_d(:,k)=(quat(:,k+1)-quat(:,k)) / (t(k+1)-t(k));
%     elseif (k==nb_step)
%         quat_d(:,k)=(quat(:,k)-quat(:,k-1)) / (t(k)-t(k-1));
%     else
%         quat_d(:,k)=(quat(:,k+1)-quat(:,k-1)) / (t(k+1)-t(k-1));
%     end
% end
% 
% for k=1:nb_step
%     eul = quat2eul(transpose(quat(:,k)),'XYZ');
%     Rx=rot_x(q(4,k)*pi/180);
%     Ry=rot_x(q(4,k)*pi/180)*rot_y(q(5,k)*pi/180);
%     Omega(:,k)=eul(1)*x + eul(2)*Rx*y + eul(3)*Ry*z;
% end
%quatmultiply(q,r)


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

%Omega=zeros(3,nb_step);
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