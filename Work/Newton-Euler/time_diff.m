%Made by Nicolas Testard if there is any question

function [qd,qdd]=time_diff(q,t)

qd=zeros(size(q,1),size(q,2)-4);
qdd=qd;

for k=3:(length(t)-3)
    qd(:,k-1)=(q(:,k+1)-q(:,k-1)) / (t(k+1)-t(k-1));
    qdd(:,k-1)= (q(:,k+2)-2*q(:,k)+q(:,k-2)) / ( ( t(k+1)-t(k-1) )^2 );
end

end