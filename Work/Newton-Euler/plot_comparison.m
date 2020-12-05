function []=plot_comparison(time1,W1,time2,W2,names)

subplot(3,2,1)
hold off
plot(time1,W1(1,:))
hold on
plot(time2,W2(1,:))
title("Fx")
legend(names(1),names(2))
xlabel("Time (s)")
ylabel("Force (N)")

subplot(3,2,3)
hold off
plot(time1,W1(2,:))
hold on
plot(time2,W2(2,:))
title("Fy")
legend(names(1),names(2))
xlabel("Time (s)")
ylabel("Force (N)")

subplot(3,2,5)
hold off
plot(time1,W1(3,:))
hold on
plot(time2,W2(3,:))
title("Fz")
legend(names(1),names(2))
xlabel("Time (s)")
ylabel("Force (N)")

subplot(3,2,2)
hold off
plot(time1,W1(4,:))
hold on
plot(time2,W2(4,:))
title("Tx")
legend(names(1),names(2))
xlabel("Time (s)")
ylabel("Torque (N.m)")

subplot(3,2,4)
hold off
plot(time1,W1(5,:))
hold on
plot(time2,W2(5,:))
title("Ty")
legend(names(1),names(2))
xlabel("Time (s)")
ylabel("Torque (N.m)")

subplot(3,2,6)
hold off
plot(time1,W1(6,:))
hold on
plot(time2,W2(6,:))
title("Tz")
legend(names(1),names(2))
xlabel("Time (s)")
ylabel("Torque (N.m)")