%Made by Nicolas Testard if there is any question

function [X1,Y1,Z1]=trans_rot3(X,Y,Z,q)
X1=X; Y1=Y; Z1=Z;
%u=[1;0;0];
%theta=q(4)*pi/180;

theta=norm(q(4:6)*pi/180);

%u=[q(6);q(5);q(4)]*(pi/180)/theta;

u=q(4:6)*(pi/180)/theta;
R=rot_u(u,theta);

%R=eye(3);
for i=1:size(X,1)
    for j=1:size(X,2)
        v=transpose(R*[X1(i,j);Y1(i,j);Z1(i,j)]);
        X1(i,j)=v(1);
        Y1(i,j)=v(2);
        Z1(i,j)=v(3);
        
        v=[X1(i,j),Y1(i,j),Z1(i,j)]+transpose(q(1:3))*1e-3;
        v=rot_z(pi/2)*transpose(v); %change orientation when plotting
        X1(i,j)=v(1);
        Y1(i,j)=v(2);
        Z1(i,j)=v(3);
    end
end

end