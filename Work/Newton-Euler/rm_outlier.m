function [qd,qdd]=rm_outlier(qd,qdd)
L=length(qd);
k=3;
while(k<L-3)
    if abs(qd(k))>(5)*abs(qd(k-1))||abs(qd(k+1))>(5)*abs(qd(k+2))
        if abs(qdd(k-1))>50*abs(qdd(k-2))||abs(qdd(k+2))>50*abs(qdd(k+3))
            
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