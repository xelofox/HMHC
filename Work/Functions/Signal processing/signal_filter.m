function signal=signal_filter(signal,dt)

[b,a]=butter(4,4/((1/(2*(2*dt)))/2));

[B,A] = butter(2,20*2*dt);
for i=1:size(signal,1)
    for j=1:size(signal,2)
        signal(i,:) = medfilt1(signal(i,:),11);
        %signal(i,:)=filtfilt(B,A,squeeze(signal(i,:)));        
    end
end