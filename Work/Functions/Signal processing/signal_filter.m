function signal=signal_filter(signal,dt)


warning off

[B,A] = butter(2,20*2*dt);

%plot(signal')

for i=1:size(signal,1)
    for j=1:size(signal,2)
        if ( isnan(signal(i,j)) )||( isinf(signal(i,j))  )
            signal(i,j)=0;
        end
    end
end


for i=1:size(signal,1)
    for j=1:10
        signal(i,:) = medfilt1(signal(i,:),11);           
    end
    signal(i,:)=filtfilt(B,A,signal(i,:));
end