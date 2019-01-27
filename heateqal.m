function C=heateqal(x)%V_g,V_mw;
%%V_g是缸的体积，L为人体的传热厚度,V_mw是人在水中的体积，S_w是缸的水面的面积,S_g是缸的接触面积,,K_ge为缸壁
%%的温度,为缸壁的厚度,S_mw是人在水中的表面积,K_0是初始温度（适合洗澡的温度多数资料显示37-42之间较好，记为38
%%.5)K_1是稳定后的水温，K_2是水龙头水水温记为45度，K_3是浴室室温记为28度,K_m人体温度）c是水的比热容；
m_0=x(1);
t_0=x(2);
t_1=x(3);
S_w=1.064;
S_g=1.976;
S_mw=2;
d=0.2;
h=500;
L=0.03;
V_g=0.1584;
V_mw=0.059;
namuta=0.635;
namuta1=0.19;
namuta2=0.2;
beita= 0.009;
c=4181;
K_2=45;
K_3=28;
K_ge=17;
K_m=32.5;
C=38.5;
Q_in=c*m_0*K_2;
Q_out1=S_w*h*abs(C(end)-K_3);
Q_out2=S_g*namuta1*abs(C(end)-K_ge)/d;
Q_out3=S_mw*namuta2*abs(C(end)-K_m)/L;
Q_out4=c*m_0*C(end);
% Q_out5=0.97*56.7*(S_w+S_g)*C(end)^4;
Q_out6=beita*S_w*(94.6926-77.329);
Q_out5=0;
DQ=Q_in-(Q_out1+Q_out2+Q_out3+Q_out4+Q_out5+Q_out6);
DQ1=-(Q_out1+Q_out2+Q_out3+Q_out5+Q_out6);
T=t_0+t_1;
point_num = 2000;
for i=linspace(0.01,T,point_num)
    if(i<=t_0)
        C=[C C(end)+DQ*0.01/(c*(V_g-V_mw)*1000)];
    else
        C=[C C(end)+DQ1*0.01/(c*(V_g-V_mw)*1000)];
    end
end

plot(linspace(0.01,T,point_num+1),C);
%m_0=((S_w*h+S_g*namuta1/d+S_mw*namuta2/L)*K_1+beita*S_w*(94.6926-77.329)+0.97*56.7*(S_w+S_g)*K_1^4-S_w*h*K_3-S_g*namuta/d*K_ge-S_mw*namuta/L*K_m)/(c*(K_2-K_1));
%K_1=(m_0*(c*(K_2-K_1))-beita*S_w*(94.6926-77.329)+0.97*56.7*(S_w+S_g)*K_1^4-S_w*h*K_3-S_g*namuta/d*K_ge-S_mw*namuta/L*K_m)/(S_w*h+S_g*namuta1/d+S_mw*namuta2/L)




