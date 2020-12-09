function newTime= adapt_time(Motion,time)

if Motion=="quickJump"
    newTime=time-time(1)+1.25; 
elseif Motion=="maxJump"
    newTime=time-time(1)+1.7;
elseif Motion=="medJump"
    newTime=time-time(1)+1;
elseif Motion=="slowArm"
    newTime=time-time(1)+2;
elseif Motion=="mediumArm"
    newTime=time-time(1)+2.35;
elseif Motion=="custom"
    newTime=time-time(1)+1.25;
    
    
else
    newTime=time-time(1);
end


end