clear
Motion="maxJump";
data=importdata(Motion+".csv");
ground.time=data.data(:,2);
ground.Fx=data.data(:,3);
ground.Fy=data.data(:,4);
ground.Fz=data.data(:,5);
ground.Mx=data.data(:,6);
ground.My=data.data(:,7);
ground.Mz=data.data(:,8);
ground.CoPx=data.data(:,9);
ground.CoPy=data.data(:,10);

save("ground/"+Motion+"_ground",'ground');

clear data Motion




