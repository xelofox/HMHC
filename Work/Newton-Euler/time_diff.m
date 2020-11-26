%Made by Nicolas Testard if there is any question

%We apply a discrete time derivative to each array of values
% qd(k)=(q(k+1)-q(k)) / (t(k+1)-t(k));
function [qd,qdd]=time_diff(q,t)

qd=zeros(size(q,1),size(q,2));
qdd=qd;

for k=1:size(q,2)
    if k==1
        qd(:,k)=(q(:,k+1)-q(:,k)) / (t(k+1)-t(k));
    elseif k==size(q,2)
        qd(:,k)=(q(:,k)-q(:,k-1)) / (t(k)-t(k-1));
    else
        qd(:,k-1)=(q(:,k+1)-q(:,k-1)) / (t(k+1)-t(k-1));
    end
end

for k=1:size(q,2)
    if k==1
        qdd(:,k)=(qd(:,k+1)-qd(:,k)) / (t(k+1)-t(k));
    elseif k==size(q,2)
        qdd(:,k)=(qd(:,k)-qd(:,k-1)) / (t(k)-t(k-1));
    else
        qdd(:,k-1)=(qd(:,k+1)-qd(:,k-1)) / (t(k+1)-t(k-1));
    end
end

end