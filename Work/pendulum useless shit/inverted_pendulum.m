syms x1 y1 x1d y1d x1dd y1dd Fx1 Fy1 m1 g T l1 q1 q1d q1dd

x1 = - l1 * sin(q1);
y1 = + l1 * cos(q1);

x1d = - l1 * cos(q1) * q1d;
y1d = - l1 * sin(q1) * q1d;

x1dd = + l1 * sin(q1) * q1d * q1d - l1 * cos(q1) * q1dd;
y1dd = - l1 * cos(q1) * q1d * q1d - l1 * sin(q1) * q1dd;

Fx1 = m1 * x1dd;
Fy1 = m1 * y1dd - m1 * g;

T = simplify(m1 * cross([x1 y1 0],[x1dd y1dd-g 0]));
T = T(3)

%T = m1*l1^2*q1dd + g*m1*l1*sin(q1)

q1dd = T/(m1*l1^2) - g*m1*l1*sin(q1);