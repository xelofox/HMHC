function []=plot_comparison2(time1,W1,time2,W2,names)

subplot(1,3,1)
hold off
plot(time1,W1(1,:))
hold on
plot(time2,W2(1,:))
title("Force along x")
legend(names(1),names(2))
xlabel("Time (s)")
ylabel("Force (N)")

subplot(1,3,2)
hold off
plot(time1,W1(2,:))
hold on
plot(time2,W2(2,:))
title("Force along y")
legend(names(1),names(2))
xlabel("Time (s)")
ylabel("Force (N)")

subplot(1,3,3)
hold off
plot(time1,W1(3,:))
hold on
plot(time2,W2(3,:))
title("Force along z")
legend(names(1),names(2))
xlabel("Time (s)")
ylabel("Force (N)")

subplot(1,3,1)
hold off
plot(time1,W1(4,:))
hold on
plot(time2,W2(4,:))
title("Torque around x")
legend(names(1),names(2))
xlabel("Time (s)")
ylabel("Torque (N.m)")

subplot(1,3,2)
hold off
plot(time1,W1(5,:))
hold on
plot(time2,W2(5,:))
title("Torque around y")
legend(names(1),names(2))
xlabel("Time (s)")
ylabel("Torque (N.m)")

subplot(1,3,3)
hold off
plot(time1,W1(6,:))
hold on
plot(time2,W2(6,:))
title("Torque around z")
legend(names(1),names(2))
xlabel("Time (s)")
ylabel("Torque (N.m)")
