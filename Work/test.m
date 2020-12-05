Motion="slowArm";
Hanavan;

load(Motion+"_q.mat")
motion.time=adapt_time(Motion,motion.time);

load(Motion+"_ground.mat")


% nb_step=length(motion.time);
% 
% for k=1:nb_step
%     Head.pos(:,k)=CoM_pos_orientation(Head,motion.J4(:,k));
% end
% 
% q=motion.J4;
% 
% [Head.velocity,Head.acceleration]=time_diff(Head.pos,motion.time);
% 
% [qd,qdd]=time_diff(q,motion.time);
% 
% x=[1;0;0] ; y=[0;1;0] ; z=[0;0;1];
% 
% for k=1:length(motion.time)
%     Rx=rot_x(q(4,k)*pi/180);
%     Ry=rot_x(q(4,k)*pi/180)*rot_y(q(5,k)*pi/180);
%     Rz=rot_x(q(4,k)*pi/180)*rot_y(q(5,k)*pi/180)*rot_z(q(6,k)*pi/180);
%     
%     omega(:,k)=qd(4,k)*x+qd(5,k)*Rx*y+qd(6,k)*Ry*z;
% end
% k=6;
% hold off
% plot(Head.velocity(k,:))
% hold on
% plot(omega(k-3,:))

[Head.pos,Head.vel,Head.acc]=kinematic(Head,motion.time,motion.J4)