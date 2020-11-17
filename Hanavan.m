%Made by Nicolas Testard if there is any question

%% Hanavan parameters
P=[ 0.1940;
    0.1000;
    0.2836;
    0.3292;
    0.3484;
    0.2698;
    0.3992;
    0.3906;
    0.2196;
    0.2186;
    0.2592;
    0.1276;
    0.1638;
    0.2818;
    0.1756;
    0.2562;
    0.2610;
    0.3163;
    0.2424;
    0.2315;
    0.0834;
    0.2466;
    0.3492;
    0.3890;
    0.4676;
    0.5512;
    0.9818;
    0.8948;
    0.7976;
    0.9422;
    0.1038;
    0.0700;
    0.0942;
    0.0282;
    0.1834;
    0.3262;
    0.2996;
    0.3122;
    0.3070;
    0.3012;
    0.57725];

%% Hanavan model

%Hand
Hand.shape="ER";
Hand.group="SE";
Hand.a=P(14)/(2*pi);
Hand.b=Hand.a;
Hand.c=P(2)/2;

%Forearm
Forearm.shape="TCC";
Forearm.group="ES";
Forearm.a0=P(17)/(2*pi);
Forearm.b0=Forearm.a0;
Forearm.a1=P(15)/(2*pi);
Forearm.b1=Forearm.a1;
Forearm.L=P(3);

%Upperarm
Upperarm.shape="TCC";
Upperarm.group="ES";
Upperarm.a0=P(18)/(2*pi);
Upperarm.b0=Upperarm.a0;
Upperarm.a1=P(17)/(2*pi);
Upperarm.b1=Upperarm.a1;
Upperarm.L=P(5);

%Foot
Foot.shape="ES Circ. Base";
Foot.group="ES";
Foot.a0=P(19)/(2*pi);
Foot.b0=Foot.a0;
Foot.a1=(P(33)+P(34))/4;
Foot.b1=(P(20)+P(21))/4;
Foot.L=P(6);

%Shank
Shank.shape="TCC";
Shank.group="ES";
Shank.a0=P(24)/(2*pi);
Shank.b0=Shank.a0;
Shank.a1=P(22)/(2*pi);
Shank.b1=Shank.a1;
Shank.L=P(7);

%Thigh
Thigh.shape="ES Circ. Top";
Thigh.group="ES";
Thigh.b0=P(35)/2;
Thigh.a0=P(25)/pi-Thigh.b0;
Thigh.a1=P(24)/(2*pi);
Thigh.b1=Thigh.a1;
Thigh.L=P(8);

%Head
Head.shape="ER";
Head.group="SE";
Head.a=P(26)/(2*pi);
Head.b=Head.a;
Head.c=P(9)/2;

%U_Trunk
U_Trunk.shape="EC";
U_Trunk.group="ES";
U_Trunk.a0=(P(36)+P(37))/4;
U_Trunk.b0=(P(27)+P(28))/(2*pi)-U_Trunk.a0;
U_Trunk.a1=U_Trunk.a0;
U_Trunk.b1=U_Trunk.b0;
U_Trunk.L=P(11);

%M_Trunk
M_Trunk.shape="ES";
U_Trunk.group="ES";
M_Trunk.a0=P(37)/2;
M_Trunk.b0=P(28)/pi-M_Trunk.a0;
M_Trunk.a1=P(38)/2;
M_Trunk.b1=P(29)/pi-M_Trunk.a0;
M_Trunk.L=P(12);

%L_Trunk
L_Trunk.shape="EC";
L_Trunk.group="ES";
L_Trunk.a0=(P(38)+P(39))/4;
L_Trunk.b0=(P(29)+P(30))/(2*pi)-L_Trunk.a0;
L_Trunk.a1=L_Trunk.a0;
L_Trunk.b1=L_Trunk.b0;
L_Trunk.L=P(13);

%% Volume
Hand.volume=Volume_SE_group(Hand);
Forearm.volume=Volume_ES_group(Forearm);
Upperarm.volume=Volume_ES_group(Upperarm);
Foot.volume=Volume_ES_group(Foot);
Shank.volume=Volume_ES_group(Shank);
Thigh.volume=Volume_ES_group(Thigh);
Head.volume=Volume_SE_group(Head);
U_Trunk.volume=Volume_ES_group(U_Trunk);
M_Trunk.volume=Volume_ES_group(M_Trunk);
L_Trunk.volume=Volume_ES_group(L_Trunk);

Vtot=2*Hand.volume+2*Forearm.volume+2*Upperarm.volume+2*Foot.volume+2*Shank.volume+2*Thigh.volume+...
    Head.volume+U_Trunk.volume+M_Trunk.volume+L_Trunk.volume;

%% Mass
Mtot=82.4595;

Hand.m=Mtot*Hand.volume/Vtot;
Forearm.m=Mtot*Forearm.volume/Vtot;
Upperarm.m=Mtot*Upperarm.volume/Vtot;
Foot.m=Mtot*Foot.volume/Vtot;
Shank.m=Mtot*Shank.volume/Vtot;
Thigh.m=Mtot*Thigh.volume/Vtot;
Head.m=Mtot*Head.volume/Vtot;
U_Trunk.m=Mtot*U_Trunk.volume/Vtot;
M_Trunk.m=Mtot*M_Trunk.volume/Vtot;
L_Trunk.m=Mtot*L_Trunk.volume/Vtot;


%% Inertia
Hand.inertia=Inertia_SE_group(Hand);
Forearm.inertia=Inertia_ES_group(Forearm);
Upperarm.inertia=Inertia_ES_group(Upperarm);
Foot.inertia=Inertia_ES_group(Foot);
Shank.inertia=Inertia_ES_group(Shank);
Thigh.inertia=Inertia_ES_group(Thigh);
Head.inertia=Inertia_SE_group(Head);
U_Trunk.inertia=Inertia_ES_group(U_Trunk);
M_Trunk.inertia=Inertia_ES_group(M_Trunk);
L_Trunk.inertia=Inertia_ES_group(L_Trunk);