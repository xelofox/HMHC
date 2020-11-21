Motion="slowArm";
Hanavan;
load(Motion+"_q.mat")

%[X,Y,Z] = ellipsoid(xc,yc,zc,xr,yr,zr,n)
%[X,Y,Z] = cylinder(r,n)
R=2;H=2
[X,Y,Z] = cylinder(R/H);
X=H*X;Y=H*Y;Z=H*Z
hold on
surf(X,Y,Z)
X=X+1;Y=Y+1;Z=Z+1
surf(X,Y,Z)
[X,Y,Z] = ellipsoid(0,0,0,1,1,2)
surf(X,Y,Z)