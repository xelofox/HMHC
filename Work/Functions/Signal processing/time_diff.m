
%We apply a discrete time derivative to each array of values
% qd(k)=(q(k+1)-q(k)) / (t(k+1)-t(k));
function [qd,qdd]=time_diff(q,t)

qd=zeros(size(q,1),size(q,2));
qdd=qd;
L=length(t);

for k=1:L
    if k==1
        qd(:,k)=(q(:,k+1)-q(:,k)) / (t(k+1)-t(k));
    elseif k==L
        qd(:,k)=(q(:,k)-q(:,k-1)) / (t(k)-t(k-1));
    else
        qd(:,k)=(q(:,k+1)-q(:,k-1)) / (t(k+1)-t(k-1));
    end
end

dt=t(2)-t(1);
qd=signal_filter(qd,dt);

for k=1:L
    if k==1
        qdd(:,k)=(qd(:,k+1)-qd(:,k)) / (t(k+1)-t(k));
    elseif k==L
        qdd(:,k)=(qd(:,k)-qd(:,k-1)) / (t(k)-t(k-1));
    else
        qdd(:,k)=(qd(:,k+1)-qd(:,k-1)) / (t(k+1)-t(k-1));
    end
end
%qdd=signal_filter(qdd,dt);


end