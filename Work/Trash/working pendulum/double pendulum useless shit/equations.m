syms x1 x1d x1dd y1 y1d y1dd q1 q1d q1dd Fx1 Fy1 T1 T1_ m1 l1 x2 x2d x2dd y2 y2d y2dd q2 q2d q2dd Fx2 Fy2 T2 T2_ m2 l2 g

x1 = - l1 * sin(q1);
y1 = + l1 * cos(q1);
x2 = - l1 * sin(q1) - l2 * sin(q1+q2);
y2 = + l1 * cos(q1) + l2 * cos(q1+q2);

x1d = - l1*cos(q1)* q1d;
y1d = - l1*sin(q1)* q1d;
x2d = - l1*cos(q1)*q1d - l2*cos(q1 + q2)*(q1d + q2d);
y2d = - l1*sin(q1)*q1d - l2*sin(q1 + q2)*(q1d + q2d);

x1dd = - l1*cos(q1)*q1dd + l1*sin(q1)*q1d^2;
y1dd = - l1*sin(q1)*q1dd - l1*cos(q1)*q1d^2;
x2dd = - l1*cos(q1)*q1dd + l1*sin(q1)*q1d^2 - l2*cos(q1 + q2)*(q1dd + q2dd) + l2*sin(q1 + q2)*(q1d + q2d)^2;
y2dd = - l1*sin(q1)*q1dd - l1*cos(q1)*q1d^2 - l2*sin(q1 + q2)*(q1dd + q2dd) - l2*cos(q1 + q2)*(q1d + q2d)^2;

Fx1 = m1 * x1dd;
Fy1 = m1 * y1dd - m1 * g;

T2 = simplify(m2 * cross([(x2-x1) (y2-y1) 0],[(x2dd-x1dd) (y2dd-y1dd-g) 0]));
T2 = T2(3);
T1_1 = simplify(m1 * cross([(x1) (y1) 0],[(x1dd) (y1dd-g) 0]));
T1_1 = T1_1(3);
T1_2 = simplify(m2 * cross([(x2) (y2) 0],[(x2dd) (y2dd-g) 0]));
T1_2 = T1_2(3);
T1 = T1_1 + T1_2;




%{
sol = solve([T1_==T1,T2_==T2], [q1dd, q2dd]);

q1dd_ = sol.q1dd
q2dd_ = sol.q2dd
%}

