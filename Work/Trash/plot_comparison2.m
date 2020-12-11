function []=plot_comparison2(time1,W1,time2,W2,names)

% subplot(1,3,1)
% hold off
% plot(time1,W1(1,:))
% hold on
% plot(time2,W2(1,:))
% title("Force along x")
% legend(names(1),names(2))
% xlabel("Time (s)")
% ylabel("Force (N)")
% 
% subplot(1,3,2)
% hold off
% plot(time1,W1(2,:))
% hold on
% plot(time2,W2(2,:))
% title("Force along y")
% legend(names(1),names(2))
% xlabel("Time (s)")
% ylabel("Force (N)")
% 
% subplot(1,3,3)
% hold off
% plot(time1,W1(3,:))
% hold on
% plot(time2,W2(3,:))
% title("Force along z")
% legend(names(1),names(2))
% xlabel("Time (s)")
% ylabel("Force (N)")
% 
% for k=1:3
%     subplot(1,3,k)
%     i=k;
%     M=max( max(W1(i,:)), max(W2(i,:))   )*1.4;
%     m=min( min(W1(i,:)), min(W2(i,:))   )*1.4;
%     m=m*(-sign(m));
%     axis([12.2 15 m M]) %slowArm
%     %axis([7 10.5 m M]) %mediumArm
%     %axis([7.5 9.5 m M]) %fastArm
% end
% 
% subplot(1,3,1)
% hold off
% plot(time1,W1(4,:))
% hold on
% plot(time2,W2(4,:))
% title("Torque around x")
% legend(names(1),names(2))
% xlabel("Time (s)")
% ylabel("Torque (N.m)")
% 
% subplot(1,3,2)
% hold off
% plot(time1,W1(5,:))
% hold on
% plot(time2,W2(5,:))
% title("Torque around y")
% legend(names(1),names(2))
% xlabel("Time (s)")
% ylabel("Torque (N.m)")
% 
% subplot(1,3,3)
% hold off
% plot(time1,W1(6,:))
% hold on
% plot(time2,W2(6,:))
% title("Torque around z")
% legend(names(1),names(2))
% xlabel("Time (s)")
% ylabel("Torque (N.m)")

%% Toc

subplot(2,2,1)
hold off
plot(time1,W1(1,:))
hold on
plot(time2,W2(1,:))
title("Force along x")
legend(names(1),names(2))
xlabel("Time (s)")
ylabel("Force (N)")
grid on

subplot(2,2,2)
hold off
plot(time1,W1(2,:))
hold on
plot(time2,W2(2,:))
title("Force along y")
legend(names(1),names(2))
xlabel("Time (s)")
ylabel("Force (N)")
grid on

subplot(2,2,3)
hold off
plot(time1,W1(3,:))
hold on
plot(time2,W2(3,:))
title("Force along z")
legend(names(1),names(2))
xlabel("Time (s)")
ylabel("Force (N)")
grid on



subplot(2,2,4)
hold off
plot(time1,W1(6,:))
hold on
plot(time2,W2(6,:))
title("Torque around z")
legend(names(1),names(2))
xlabel("Time (s)")
ylabel("Torque (N.m)")
grid on

for k=1:4
    subplot(2,2,k)
    i=k;
    if k==4
        i=6;
    end
    M=max( max(W1(i,:)), max(W2(i,:))   )*1.4;
    m=min( min(W1(i,:)), min(W2(i,:))   )*1.4;
    m=m*(-sign(m));
    axis([12.2 15 m M]) %slowArm
    %axis([7 10.5 m M]) %mediumArm
    %axis([7.5 9.5 m M]) %fastArm
end