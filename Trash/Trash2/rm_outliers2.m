%Made by Nicolas Testard if there is any question

function [qd]=rm_outliers2(t,q,qd)
nb_step=length(qd);
k=4;



% qd=filloutliers(qd,'linear','movmedian',40);
% qdd=filloutliers(qdd,'linear','movmedian',40);

for k=1:nb_step
    for i=1:3
        if (k==1)
            qdd(i,k)=(qd(i,k+1)-qd(i,k)) / (t(k+1)-t(k));
        elseif (k==nb_step)
            qdd(i,k)=(qd(i,k)-qd(i,k-1)) / (t(k)-t(k-1));
        else
            qdd(i,k)=(qd(i,k+1)-qd(i,k-1)) / (t(k+1)-t(k-1));
        end
    end
end

while(k<nb_step-4)
    %if ( abs(qd(k)-qd(k-1))>5*abs(qd(k-1)-qd(k-2)) )&&( abs(qd(k+2)-qd(k+1))>5*abs(qd(k+3)-qd(k+2)) )
    %if ( abs(qd(k)-qd(k-1))>abs(qd(k-1)-qd(k-2)) )&&( abs(qd(k+2)-qd(k+1))>abs(qd(k+3)-qd(k+2)) )
        if ( abs(qdd(k)-qdd(k+1))>(1.5)*abs(qdd(k)) )&&( abs(qdd(k)-qdd(k+1))>(1.5)*abs(qdd(k+1)) )
        %if ( abs(qdd(k)-qdd(k+1))>(1.8)*abs(qdd(k)) )&&( abs(qdd(k)-qdd(k+1))>(1.8)*abs(qdd(k+1)) )
            
            qd(k)=(q(k)-q(k-1)) / (t(k)-t(k-1));
            qd(k+1)=(q(k+2)-q(k+1)) / (t(k+2)-t(k+1));
           %if ( abs(qdd(k)-qdd(k+1))>(1.4)*abs(qdd(k)) )&&( abs(qdd(k)-qdd(k+1))>(1.4)*abs(qdd(k+1)) )

        
%     else
%         k=k+1;
%     end
end


end