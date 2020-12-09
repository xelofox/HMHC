function signal=signal_filter(signal,dt)
%We apply a median filter tht destroys the peacks (atipic values)
%Then we apply a butterwort lower-pass filter, to destroy the frequencies
%higher than 20Hz( which is the order of magnitude of human movement)


warning off



%plot(signal')

for i=1:size(signal,1)
    for j=1:size(signal,2)
        if ( isnan(signal(i,j)) )||( isinf(signal(i,j))  )
            signal(i,j)=0;
        end
    end
end

%definition of the frequency for the butterwort lower-pass filter
[B,A] = butter(2,20*2*dt);

for i=1:size(signal,1)
    for j=1:10
        signal(i,:) = medfilt1(signal(i,:),11);           
    end
    signal(i,:)=filtfilt(B,A,signal(i,:));
end