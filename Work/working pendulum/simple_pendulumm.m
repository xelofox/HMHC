%get the equations of the Force and Torque
[F_,T_,E_,U_] = compute_equation();

%konstant parameters
m = 1;
l = 1;
g = 9.81;

%Sample Time
n_samples = 100;
final_time = 1;
period = final_time/n_samples;

%initial conditions
q_0 = 90 *pi/180;
qd_0 = 0;
qdd_0 = 0;

%final conditions
q_f = -90 *pi/180;
qd_f = 0;
qdd_f = 0;

%input calculation through polinomials
%joint 1
syms a0 a1 a2 a3 a4 a5
%position equations
eq1=a0*0^5+a1*0^4+a2*0^3+a3*0^2+a4*0+a5==q_0;
eq2=a0*final_time^5+a1*final_time^4+a2*final_time^3+a3*final_time^2+a4*final_time+a5==q_f;
%velocity equations
eq3=a0*5*0^4+a1*4*0^3+3*a2*0^2+2*a3*0+a4==qd_0;
eq4=a0*5*final_time^4+a1*4*final_time^3+3*a2*final_time^2+2*a3*final_time+a4==qd_f;
%acceleration equations
eq5=a0*5*0^4+a1*4*0^3+3*a2*0^2+2*a3*0+a4==qdd_0;
eq6=a0*5*4*final_time^3+a1*4*3*final_time^2+3*2*a2*final_time+2*a3==qdd_f;

sol1 = solve([eq1,eq2,eq3,eq4,eq5,eq6], [a0,a1,a2,a3,a4,a5]);
a0=sol1.a0; a1=sol1.a1; a2=sol1.a2; a3=sol1.a3; a4=sol1.a4; a5=sol1.a5; 

i=1;
%build polinomials
for t = 0:period:final_time
    q(i) = a0*t^5+a1*t^4+a2*t^3+a3*t^2+a4*t+a5;
    qd(i) = a0*5*t^4+a1*4*t^3+3*a2*t^2+2*a3*t+a4;
    qdd(i) = a0*5*4*t^3+a1*4*3*t^2+3*2*a2*t+2*a3;
    i=i+1;
end

%convert syms to double to make the computation of the animation faster
q=double(q);qd=double(qd);qdd=double(qdd);

figure('units','normalized','outerposition',[0 0 1 1])

t_size = size(q);
t_size = t_size(2);

%Compute the Torques and Forces
syms q_ q_d q_dd m_ l_ g_

T(t_size) = 0;
for t = 1:1:t_size
T(t) = subs(T_,[q_ q_d q_dd m_ l_ g_],[q(t) qd(t) qdd(t) m l g]);
end
T = double(T);

Fx(t_size) = 0;
Fy(t_size) = 0;
for t = 1:1:t_size
	Fx(t) = subs(F_(1),[q_ q_d q_dd m_ l_ g_],[q(t) qd(t) qdd(t) m l g]);
    Fy(t) = subs(F_(2),[q_ q_d q_dd m_ l_ g_],[q(t) qd(t) qdd(t) m l g]);
end

%% Animation and plots
% Annimation
for t = 1:1:t_size
clf

nexttile([3 3])
hold on
axis([-l-0.2 +l+0.2 -l-0.2 +l+0.2])
x = cos(q(t)+pi/2);
y = sin(q(t)+pi/2);
circle(x*l, y*l,0.1)
plot([0 x*(l-0.1)], [0 y*(l-0.1)])
title('Animation')
hold off

% Torque plot
nexttile([2 2])
hold on
xmax = t_size;
ymax = max(T);
ymin = min(T);
axis([0 xmax ymin ymax])
plot(T(1:t))
title('Torque')
hold off


% Force plot
nexttile([2 2])
title('Force')
hold on
xmax = t_size;
ymax = max(max(Fx),max(Fy));
ymin = min(min(Fx),min(Fy));
axis([0 xmax ymin ymax])
plot(Fx(1:t))
plot(Fy(1:t))
hold off
legend('F x','F y')

pause(period)

end

%% Functions
function h = circle(x,y,r)
th = 0:10:360;
xunit = r * cosd(th) + x;
yunit = r * sind(th) + y;
h = plot(xunit, yunit,'LineWidth',1,'Color',"black");
axis("equal");
end

function [F_,T_,E_,U_] = compute_equation()

syms x xd xdd y yd ydd q_ q_d q_dd Fx Fy T T_ m_ l_ g_

x = - l_ * sin(q_);
y = + l_ * cos(q_);

xd = - l_*cos(q_)* q_d;
yd = - l_*sin(q_)* q_d;

xdd = - l_*cos(q_)*q_dd + l_*sin(q_)*q_d^2;
ydd = - l_*sin(q_)*q_dd - l_*cos(q_)*q_d^2;

%% Forces
%Outter Forces
F_g = m_ * [0 -g_ 0]; %F=m*g
%%Inner Forces
F_1 = 0; %F=m*a (refered to the origin of the frame (where m))
F_2 = cross([0 0 q_dd],m_*[x y 0]); %F=cross(w' , m*(X2-X))
F_3 = cross([0 0 q_d],cross([0 0 q_d],m_*[x y 0])); %cross(w ,cross(w , m*(X)))
F_ = F_1 + F_2 + F_3 - F_g;

%% Torques
%Outter Torques
T_g = cross([x y 0],[0 -m_*g_ 0]); %T = cross(l2,m*g)
%%Inner Torques
T_1 = (m_*l_^2) * [0 0 (q_dd)]; %T = I*w'
T_2 = cross([(x) (y) 0],[xdd ydd 0]); %T = cross(ms,a)
T_ = T_1 + T_2 - T_g;
T_ = simplify(T_(3));

%% Energy
M = m_*eye(3);
I = [0 0 0 ; 0 0 0 ; 0 0 m_*l_^2];
msi = [0 x -y ; -x 0 0 ; y 0 0];

E_ = 1/2 * [xd yd 0 0 0 q_d] * [M msi' ; msi I] * [xd ; yd ; 0 ; q_d ; 0 ; 0];
U_ = m_ * g_ * y;


end