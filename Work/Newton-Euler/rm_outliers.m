function [qd,qdd]=rm_outliers(qd,qdd)
L=length(qd);
k=4;
while(k<L-4)
    if ( abs(qd(k)-qd(k-1))>5*abs(qd(k-1)-qd(k-2)) )&&( abs(qd(k+2)-qd(k+1))>5*abs(qd(k+3)-qd(k+2)) )
    %if ( abs(qd(k)-qd(k-1))>2*abs(qd(k-1)-qd(k-2)) )&&( abs(qd(k+2)-qd(k+1))>2*abs(qd(k+3)-qd(k+2)) )
        if ( abs(qdd(k)-qdd(k+1))>(1.5)*abs(qdd(k)) )&&( abs(qdd(k)-qdd(k+1))>(1.5)*abs(qdd(k+1)) )
            
            qd(k)=qd(k-1)*2/3+qd(k+2)*1/3;
            qd(k+1)=qd(k-1)*1/3+qd(k+2)*2/3;
            
            qdd(k-1)=qdd(k-2)*4/5+qdd(k+3)*1/5;
            qdd(k)=qdd(k-2)*3/5+qdd(k+3)*2/5;
            qdd(k+1)=qdd(k-2)*2/5+qdd(k+3)*3/5;
            qdd(k+2)=qdd(k-2)*1/5+qdd(k+3)*4/5;
            k=k+2;
        else
            k=k+1;
        end
        
    else
        k=k+1;
    end
end



end