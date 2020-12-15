function t=CoM_pos_orientation(segment,q)
global Head U_Trunk M_Trunk L_Trunk Upperarm Forearm Hand Thigh Shank Foot %#ok<NUSED>
x=[1;0;0] ; y=[0;1;0] ; z=[0;0;1];

Rx=rot_x(q(4)*pi/180);
Ry=rot_x(q(4)*pi/180)*rot_y(q(5)*pi/180);
Rz=rot_x(q(4)*pi/180)*rot_y(q(5)*pi/180)*rot_z(q(6)*pi/180);

% theta=q(4)*x+q(5)*Rx*y+q(6)*Ry*z; % Convert Euler angle into total angle
% theta=theta*pi/180;

output=rotm2axang(Rz);
theta=output(4)*[output(1);output(2);output(3)]; % Convert Euler angle into total angle

pos_marker=q(1:3)*1e-3;

if segment.name=="Head"
    pos_CoM=pos_marker;
end

if segment.name=="U_Trunk"
    %pos_CoM=pos_marker+Rz*(-U_Trunk.L*z+segment.CoM);
    pos_CoM=pos_marker+Rz*R_ini(segment)*(-U_Trunk.L*z+segment.CoM);
end

if segment.name=="M_Trunk"
    %pos_CoM=pos_marker+Rz*(-M_Trunk.L*z+segment.CoM);
    pos_CoM=pos_marker+Rz*R_ini(segment)*(-M_Trunk.L*z+segment.CoM);
end

if segment.name=="L_Trunk"
    %pos_CoM=pos_marker+Rz*(-M_Trunk.L*z-L_Trunk.L*z+segment.CoM);
    pos_CoM=pos_marker+Rz*R_ini(segment)*(-M_Trunk.L*z-L_Trunk.L*z+segment.CoM);
end

if segment.name=="Upperarm"
    %pos_CoM=pos_marker+Rz*rot_y(pi/2)*(-Upperarm.L*z+segment.CoM);
    pos_CoM=pos_marker+Rz*R_ini(segment)*(-Upperarm.L*z+segment.CoM);
end

if segment.name=="Forearm"
    %pos_CoM=pos_marker+Rz*rot_y(pi/2)*(-Forearm.L*z+segment.CoM);
    pos_CoM=pos_marker+Rz*R_ini(segment)*(-Forearm.L*z+segment.CoM);
end

if segment.name=="Hand"
    %pos_CoM=pos_marker+Rz*rot_y(pi/2)*(-Hand.c*z+segment.CoM);
    pos_CoM=pos_marker+Rz*R_ini(segment)*(-Hand.c*z+segment.CoM);
end

if segment.name=="Thigh"
    %pos_CoM=pos_marker+Rz*rot_x(pi)*(-Thigh.L*z+segment.CoM);
    pos_CoM=pos_marker+Rz*R_ini(segment)*(-Thigh.L*z+segment.CoM);
end

if segment.name=="Shank"
    %pos_CoM=pos_marker+Rz*rot_x(pi)*(-Shank.L*z+segment.CoM);
    pos_CoM=pos_marker+Rz*R_ini(segment)*(-Shank.L*z+segment.CoM);
end

if segment.name=="Foot"
    %pos_CoM=pos_marker+Rz*rot_x(pi/2)*(-Foot.L*z+segment.CoM);
    %pos_CoM=pos_marker+Rz*rot_x(-pi/2)*(-Foot.L/2*z+segment.CoM);
    pos_CoM=pos_marker+Rz*R_ini(segment)*(-Foot.L/2*z+segment.CoM);
end

t=[pos_CoM; theta];

end