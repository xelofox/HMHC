function newTime= adapt_time(Motion,time)
if Motion=="custom2"
    newTime=time-time(1)+1.25; 
elseif Motion=="custom"
    newTime=time-time(1)+1.25; 
elseif Motion=="customL"
    newTime=time-time(1)+1.15;
elseif Motion=="fastArm"
    newTime=time-time(1)+2.10;  
elseif Motion=="fastKick"
    newTime=time-time(1)+1.80;     
elseif Motion=="fastKickArm"
    newTime=time-time(1)+2.05;   
elseif Motion=="jumpFeetUp"
    newTime=time-time(1)+1.00;
elseif Motion=="maxJump"
    newTime=time-time(1)+1.7;
elseif Motion=="mediumArm"
    newTime=time-time(1)+2.35;
elseif Motion=="mediumArmNOSTOMP"
    newTime=time-time(1)+4.40;
elseif Motion=="mediumKick"
    newTime=time-time(1)+1.40;
elseif Motion=="mediumKickArm"
    newTime=time-time(1)+1.50;
elseif Motion=="medJump"
    newTime=time-time(1)+1;  
elseif Motion=="quickJump"
    newTime=time-time(1)+1.25;  
elseif Motion=="slowArm"
    newTime=time-time(1)+2; 
elseif Motion=="slowKick"
    newTime=time-time(1)+1.25;     
elseif Motion=="slowKickArm"
    newTime=time-time(1)+1.50;   
elseif Motion=="slowSit"
    newTime=time-time(1)+2;  
    
else
    newTime=time-time(1);
end


end