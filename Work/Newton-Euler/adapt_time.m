function newTime= adapt_time(Motion,time)

if Motion=="quicJump"
    newTime=time-time(1)+1.25;
elseif Motion=="quicJump"
    newTime=time-time(1)+2;
elseif Motion=="custom"
    newTime=time-time(1)+1.25;
    
    
else
    newTime=time-time(1)+1.25;
end


end