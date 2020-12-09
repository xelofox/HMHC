function [signal,T]=signal_resampling(signal,T,newT)

ti=newT(1);
tf=newT(end);

index=find(((T>ti).*(T<tf)));
i1=index(1);i2=index(end);

signal=signal(i1:i2);
T=T(i1:i2);

sample_actual=length(T);
sample_new=length(newT);

signal=resample(signal,sample_new,sample_actual);
T=resample(T,sample_new,sample_actual);

end