clc
clear
% 在 Matlab 中，用大写字母 D 表示导数，Dy 表示 y 关于自变量的一阶导数，
% D2y 表示 y 关于自变量的二阶导数，依此类推.
% 函数 dsolve 用来解决常微分方程（组）的求解问题，可以精确解得解析解
% %求解一阶微分方程
% syms x y;
% y=dsolve('x*Dy+y-exp(x)=0','y(1)=2*exp(1)','x')
% ezplot(y)
% 
% %求解二元微分方程
% syms x y t;
% [x,y]=dsolve('Dx+5*x+y=exp(t)','Dy-x-3*y=0','x(0)=1','y(0)=0','t');
% %simplify函数可以对符号表达式进行简化simplify函数可以对符号表达式进行简化
% simplify(x)
% simplify(y)
% ezplot(x,y,[0,1.3]);
% axis auto

%求解偏微分方程
S_w=1.064;
S_g=1.976;
S_mw=2;
d=0.1;
K_1=38.5;

h=500;
L=0.03;
namuta=0.635;
namuta1=0.19;
namuta2=0.2;
beita= 0.009;
c=4181;
K_2=45;
K_3=28;
K_ge=17;
K_m=32.5;
m_0=((S_w*h+S_g*namuta1/d+S_mw*namuta2/L)*K_1+beita*S_w*(94.6926-77.329)+0.97*56.7*(S_w+S_g)*K_1^4-S_w*h*K_3-S_g*namuta/d*K_ge-S_mw*namuta/L*K_m)/(c*(K_2-K_1))

