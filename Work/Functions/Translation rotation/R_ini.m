%Initial orientation of the bodies
function R=R_ini(segment)

R=eye(3);

if segment.name=="Head"
    R=eye(3);
end

if segment.name=="U_Trunk"
    R=eye(3);
end

if segment.name=="M_Trunk"
    R=eye(3);
end

if segment.name=="L_Trunk"
    R=eye(3);
end

if segment.name=="Upperarm"
    R=rot_y(pi/2);
end

if segment.name=="Forearm"
    R=rot_y(pi/2);
end

if segment.name=="Hand"
    R=rot_y(pi/2);
end

if segment.name=="Thigh"
    R=rot_x(pi);
end

if segment.name=="Shank"
     R=rot_x(pi);
end

if segment.name=="Foot"
     R=rot_x(-pi/2);
end


end