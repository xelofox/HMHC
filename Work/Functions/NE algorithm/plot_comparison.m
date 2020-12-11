% this functions compares the plots between the Reactions obtaning from the
% simulations and the ones obtained from the measurements of the
% force-plate
function []=plot_comparison(time1,W1,time2,W2,names)

subplot(3,2,1)
hold off
plot(time1,W1(1,:))
hold on
plot(time2,W2(1,:))
title("Force along x")
legend(names(1),names(2))
xlabel("Time (s)")
ylabel("Force (N)")

subplot(3,2,3)
hold off
plot(time1,W1(2,:))
hold on
plot(time2,W2(2,:))
title("Force along y")
legend(names(1),names(2))
xlabel("Time (s)")
ylabel("Force (N)")

subplot(3,2,5)
hold off
plot(time1,W1(3,:))
hold on
plot(time2,W2(3,:))
title("Force along z")
legend(names(1),names(2))
xlabel("Time (s)")
ylabel("Force (N)")

subplot(3,2,2)
hold off
plot(time1,W1(4,:))
hold on
plot(time2,W2(4,:))
title("Torque around x")
legend(names(1),names(2))
xlabel("Time (s)")
ylabel("Torque (N.m)")

subplot(3,2,4)
hold off
plot(time1,W1(5,:))
hold on
plot(time2,W2(5,:))
title("Torque around y")
legend(names(1),names(2))
xlabel("Time (s)")
ylabel("Torque (N.m)")

subplot(3,2,6)
hold off
plot(time1,W1(6,:))
hold on
plot(time2,W2(6,:))
title("Torque around z")
legend(names(1),names(2))
xlabel("Time (s)")
ylabel("Torque (N.m)")