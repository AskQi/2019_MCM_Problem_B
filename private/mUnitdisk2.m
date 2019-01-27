function [c, ceq] = mUnitdisk2(x)
global S_w S_g S_mw K_m
% Unit disk. The vector x should be a row vector. This is to test the
% non-linear constraint functionality of pso.
%
% Non-linear constraints such that
% c(x) <= 0
% ceq(x) = 0
% Within a tolerance of options.TolCon
h=500;
L=0.03;
V_g=0.1584;
V_mw=0.059;
% namuta=0.635;
namuta1=0.19;
namuta2=0.2;
beita= 0.009;
c=4181;
K_2=45;
K_3=28;
K_ge=17;
C=38.49;
d=0.2;
Q_in=c*x(1)*K_2;
Q_out1=S_w*h*abs(C(end)-K_3);
Q_out2=S_g*namuta1*abs(C(end)-K_ge)/d;
Q_out3=S_mw*namuta2*abs(C(end)-K_m)/L;
Q_out4=c*x(1)*C(end);
Q_out5=0;
Q_out6=beita*S_w*(94.6926-77.329);
DQ=Q_in-(Q_out1+Q_out2+Q_out3+Q_out4+Q_out5+Q_out6);
DQ1=-(Q_out1+Q_out2+Q_out3+Q_out5+Q_out6);
T=x(2)+x(3);
point_num = 2000;
for i=linspace(0.01,T,point_num)
    if(i<=x(2))
        C=[C C(end)+DQ*0.01/(c*(V_g-V_mw)*1000)];
    else
        C=[C C(end)+DQ1*0.01/(c*(V_g-V_mw)*1000)];
    end
end
c1=38.45-C;
c2=C-38.55;
sum_C = sum(C);
average_C = sum_C/point_num;
% average_limit=abs(average_C-38.5)-0.01;
% c=[c1,c2,average_limit];
% c=[c1,c2,c_limit];
c=[c1,c2];
ceq = [] ;