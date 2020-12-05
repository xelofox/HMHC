%get the equations of the Force and Torque
[F1_,F2_,T1_,T2_] = compute_equation();

%konstant parameters
m1 = 1;
m2 = 1;
l1 = 1;
l2 = 1;
g = 9.81;

%Sample Time
n_samples = 100;
final_time = 1;
period = final_time/n_samples;

%initial conditions
q1_0 = 90 *pi/180;
q2_0 = 0 *pi/180;
q1d_0 = 0;
q2d_0 = 0;
q1dd_0 = 0;
q2dd_0 = 0;

%final conditions
q1_f = -90 *pi/180;
q2_f = 0 *pi/180;
q1d_f = 0;
q2d_f = 0;
q1dd_f = 0;
q2dd_f = 0;

%input calculation through polinomials
%joint 1
syms a0 a1 a2 a3 a4 a5
%position equations
eq1=a0*0^5+a1*0^4+a2*0^3+a3*0^2+a4*0+a5==q1_0;
eq2=a0*final_time^5+a1*final_time^4+a2*final_time^3+a3*final_time^2+a4*final_time+a5==q1_f;
%velocity equations
eq3=a0*5*0^4+a1*4*0^3+3*a2*0^2+2*a3*0+a4==q1d_0;
eq4=a0*5*final_time^4+a1*4*final_time^3+3*a2*final_time^2+2*a3*final_time+a4==q1d_f;
%acceleration equations
eq5=a0*5*0^4+a1*4*0^3+3*a2*0^2+2*a3*0+a4==q1dd_0;
eq6=a0*5*4*final_time^3+a1*4*3*final_time^2+3*2*a2*final_time+2*a3==q1dd_f;

sol1 = solve([eq1,eq2,eq3,eq4,eq5,eq6], [a0,a1,a2,a3,a4,a5]);
a0=sol1.a0; a1=sol1.a1; a2=sol1.a2; a3=sol1.a3; a4=sol1.a4; a5=sol1.a5; 

%joint 2
syms b0 b1 b2 b3 b4 b5
%position equations
eq1=b0*0^5+b1*0^4+b2*0^3+b3*0^2+b4*0+b5==q2_0;
eq2=b0*final_time^5+b1*final_time^4+b2*final_time^3+b3*final_time^2+b4*final_time+b5==q2_f;
%velocity equbtions
eq3=b0*5*0^4+b1*4*0^3+3*b2*0^2+2*b3*0+b4==q2d_0;
eq4=b0*5*final_time^4+b1*4*final_time^3+3*b2*final_time^2+2*b3*final_time+b4==q2d_f;
%bccelerbtion equbtions
eq5=b0*5*0^4+b1*4*0^3+3*b2*0^2+2*b3*0+b4==q2dd_0;
eq6=b0*5*4*final_time^3+b1*4*3*final_time^2+3*2*b2*final_time+2*b3==q2dd_f;

sol2 = solve([eq1,eq2,eq3,eq4,eq5,eq6], [b0,b1,b2,b3,b4,b5]);
b0=sol2.b0; b1=sol2.b1; b2=sol2.b2; b3=sol2.b3; b4=sol2.b4; b5=sol2.b5; 

i=1;
%build polinomials
for t = 0:period:final_time
    q1(i) = a0*t^5+a1*t^4+a2*t^3+a3*t^2+a4*t+a5;
    q1d(i) = a0*5*t^4+a1*4*t^3+3*a2*t^2+2*a3*t+a4;
    q1dd(i) = a0*5*4*t^3+a1*4*3*t^2+3*2*a2*t+2*a3;
    
    q2(i) = b0*t^5+b1*t^4+b2*t^3+b3*t^2+b4*t+b5;
    q2d(i) = b0*5*t^4+b1*4*t^3+3*b2*t^2+2*b3*t+b4;
    q2dd(i) = b0*5*4*t^3+b1*4*3*t^2+3*2*b2*t+2*b3;
    i=i+1;
end

%convert syms to double to make the computation of the animation faster
q1=double(q1);q1d=double(q1d);q1dd=double(q1dd);
q2=double(q2);q2d=double(q2d);q2dd=double(q2dd);

figure('units','normalized','outerposition',[0 0 1 1])

t_size = size(q1);
t_size = t_size(2);

%Compute the Torques and Forces
syms q1_ q1_d q1_dd m1_ l1_ q2_ q2_d q2_dd m2_ l2_ g_

T1(t_size) = 0;
for t = 1:1:t_size
T1(t) = subs(T1_,[q1_ q1_d q1_dd m1_ l1_ q2_ q2_d q2_dd m2_ l2_ g_],[q1(t) q1d(t) q1dd(t) m1 l1 q2(t) q2d(t) q2dd(t) m2 l2 g]);
end
T1 = double(T1);

T2(t_size) = 0;
for t = 1:1:t_size
T2(t) = subs(T2_,[q1_ q1_d q1_dd m1_ l1_ q2_ q2_d q2_dd m2_ l2_ g_],[q1(t) q1d(t) q1dd(t) m1 l1 q2(t) q2d(t) q2dd(t) m2 l2 g]);
end
T2 = double(T2);

F1x(t_size) = 0;
F1y(t_size) = 0;
for t = 1:1:t_size
	F1x(t) = subs(F1_(1),[q1_ q1_d q1_dd m1_ l1_ q2_ q2_d q2_dd m2_ l2_ g_],[q1(t) q1d(t) q1dd(t) m1 l1 q2(t) q2d(t) q2dd(t) m2 l2 g]);
    F1y(t) = subs(F1_(2),[q1_ q1_d q1_dd m1_ l1_ q2_ q2_d q2_dd m2_ l2_ g_],[q1(t) q1d(t) q1dd(t) m1 l1 q2(t) q2d(t) q2dd(t) m2 l2 g]);
end


F2x(t_size) = 0;
F2y(t_size) = 0;
for t = 1:1:t_size
	F2x(t) = subs(F2_(1),[q1_ q1_d q1_dd m1_ l1_ q2_ q2_d q2_dd m2_ l2_ g_],[q1(t) q1d(t) q1dd(t) m1 l1 q2(t) q2d(t) q2dd(t) m2 l2 g]);
    F2y(t) = subs(F2_(2),[q1_ q1_d q1_dd m1_ l1_ q2_ q2_d q2_dd m2_ l2_ g_],[q1(t) q1d(t) q1dd(t) m1 l1 q2(t) q2d(t) q2dd(t) m2 l2 g]);
end

%% Animation and plots
% Annimation

for t = 1:1:t_size
clf

nexttile([3 3])
hold on
axis([-l1-l2-0.2 +l1+l2+0.2 -l1-l2-0.2 +l1+l2+0.2])
x1 = cos(q1(t)+pi/2);
y1 = sin(q1(t)+pi/2);
x2 = cos(q1(t)+pi/2+q2(t));
y2 = sin(q1(t)+pi/2+q2(t));
circle(x1*l1, y1*l1,0.1)
circle(x1*l1+x2*l2,y1*l1+y2*l2,0.1)
plot([0 x1*(l1-0.1)], [0 y1*(l1-0.1)])
plot([x1*(l1)+x2*0.1 x1*l1+x2*(l2-0.1)], [y1*(l1)+y2*0.1 y1*l1+y2*(l2-0.1)]);
%axis([-l1-l2-0.2 +l1+l2+0.2 -l1-l2-0.2 +l1+l2+0.2])
title('Animation')
hold off

% Torque1 plot
nexttile([2 2])
hold on
xmax = t_size;
ymax = max(T1);
ymin = min(T1);
axis([0 xmax ymin ymax])
plot(T1(1:t))
title('Torque 1')
hold off

% Torque2 plot
nexttile([2 2])
hold on
xmax = t_size;
ymax = max(T2);
ymin = min(T2);
axis([0 xmax ymin ymax])
plot(T2(1:t))
title('Torque 2')
hold off

% Force1 plot
nexttile([2 2])
hold on
xmax = t_size;
ymax = max(max(F1x),max(F1y));
ymin = min(min(F1x),min(F1y));
axis([0 xmax ymin ymax])
plot(F1x(1:t))
plot(F1y(1:t))
title('Force 1')
hold off

% Force2 plot
nexttile([2 2])
hold on
xmax = t_size;
ymax = max(max(F2x),max(F2y));
ymin = min(min(F2x),min(F2y));
axis([0 xmax ymin ymax])
plot(F2x(1:t))
plot(F2y(1:t))
title('Force 2')
hold off

pause(period)

end

%% Functions
function h = circle(x,y,r)
th = 0:0.1:360;
xunit = r * cosd(th) + x;
yunit = r * sind(th) + y;
h = plot(xunit, yunit,'LineWidth',1,'Color',"black");
axis("equal");
end

function [F1_,F2_,T1_,T2_] = compute_equation()

syms x1 x1d x1dd y1 y1d y1dd q1_ q1_d q1_dd Fx1 Fy1 T1 T1_ m1_ l1_ x2 x2d x2dd y2 y2d y2dd q2_ q2_d q2_dd Fx2 Fy2 T2 T2_ m2_ l2_ g_

x1 = - l1_ * sin(q1_);
y1 = + l1_ * cos(q1_);
x2 = - l1_ * sin(q1_) - l2_ * sin(q1_+q2_);
y2 = + l1_ * cos(q1_) + l2_ * cos(q1_+q2_);

x1d = - l1_*cos(q1_)* q1_d;
y1d = - l1_*sin(q1_)* q1_d;
x2d = - l1_*cos(q1_)*q1_d - l2_*cos(q1_ + q2_)*(q1_d + q2_d);
y2d = - l1_*sin(q1_)*q1_d - l2_*sin(q1_ + q2_)*(q1_d + q2_d);

x1dd = - l1_*cos(q1_)*q1_dd + l1_*sin(q1_)*q1_d^2;
y1dd = - l1_*sin(q1_)*q1_dd - l1_*cos(q1_)*q1_d^2;
x2dd = - l1_*cos(q1_)*q1_dd + l1_*sin(q1_)*q1_d^2 - l2_*cos(q1_ + q2_)*(q1_dd + q2_dd) + l2_*sin(q1_ + q2_)*(q1_d + q2_d)^2;
y2dd = - l1_*sin(q1_)*q1_dd - l1_*cos(q1_)*q1_d^2 - l2_*sin(q1_ + q2_)*(q1_dd + q2_dd) - l2_*cos(q1_ + q2_)*(q1_d + q2_d)^2;

%% Forces body 2
%Outter Forces
F2_g = m2_ * [0 -g_ 0]; %F=m*g
%%Inner Forces
F2_1 = m2_ * [(x1dd) (y1dd) 0]; %F=m*a (refered to the origin of the frame (where m1))
F2_2 = cross([0 0 (q1_dd+q2_dd)],m2_*[(x2-x1) (y2-y1) 0]); %F=cross(w' , m*(X2-X1))
F2_3 = cross([0 0 (q1_d+q2_d)],cross([0 0 (q1_d+q2_d)],m2_*[(x2-x1) (y2-y1) 0])); %cross(w ,cross(w , m*(X2-X1)))
F2_ = F2_1 + F2_2 + F2_3 - F2_g;

%% Forces body 1
%Outter Forces
F1_g = m1_ * [0 -g_ 0]; %F=m*g
%%Inner Forces
F1_1 = 0; %F=m*a (refered to the origin of the frame (where m1))
F1_2 = cross([0 0 (q1_dd)],m1_*[(x1) (y1) 0]); %F=cross(w' , m*(X2-X1))
F1_3 = cross([0 0 (q1_d)],cross([0 0 (q1_d)],m1_*[(x1) (y1) 0])); %cross(w ,cross(w , m*(X1)))
F1_ = F1_1 + F1_2 + F1_3 - F1_g + F2_;

%% Torques of body 2
%Outter Torques
T2_g = cross([(x2-x1) (y2-y1) 0],[0 -m2_*g_ 0]); %T = cross(l2,m*g)
%%Inner Torques
T2_1 = (m2_*l2_^2) * [0 0 (q1_dd+q2_dd)]; %T = I*w'
T2_2 = cross([(x2-x1) (y2-y1) 0],[x2dd y2dd 0]); %T = cross(ms,a)
T2_ = T2_1 + T2_2 - T2_g;
T2_ = simplify(T2_(3));

%% Torques of body 1
%Outter Torques
T1_g = cross([(x1) (y1) 0],[0 -m1_*g_ 0]); %T = cross(l2,m*g)
T1_F2 = cross([(x1) (y1) 0],F2_);
%%Inner Torques
T1_1 = (m1_*l1_^2) * [0 0 (q1_dd)]; %T = I*w'
T1_2 = cross([(x1) (y1) 0],[x1dd y1dd 0]); %T = cross(ms,a)
T1_ = T1_1 + T1_2 - T1_g + T1_F2 + T2_ ;
T1_ = simplify(T1_(3));

end