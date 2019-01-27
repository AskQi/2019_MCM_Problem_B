function [c, ceq] = limit2019(x)
global km2px_bili bw_obstacle bw_port
%������Լ��
% fprintf('limits\n');
limit_x_large_than_1 = 1-x;
% x=int32(x);
radio_km=26.3;
radio_px = km2px_bili*radio_km;
% % ���˻��ܹ������λ��
osi_1_x=x(1);
osi_1_y=x(2);
osi_2_x=x(3);
osi_2_y=x(4);
osi_3_x=x(5);
osi_3_y=x(6);
osi_1_canshu=[osi_1_x,osi_1_y];
osi_2_canshu=[osi_2_x,osi_2_y];
osi_3_canshu=[osi_3_x,osi_3_y];

port_1=[389 483];
port_2=[888 415];
port_3=[966 453];
port_4=[1002 240];
port_5=[1334 346];

port_1_limit = norm(port_1-osi_1_canshu)-radio_px;
port_2_limit_1 = norm(port_2-osi_2_canshu)-radio_px;
port_2_limit_2 = norm(port_4-osi_2_canshu)-radio_px;
port_3_limit_1 = norm(port_3-osi_3_canshu)-radio_px;
port_3_limit_2 = norm(port_5-osi_3_canshu)-radio_px;
port_limit = [port_1_limit,port_2_limit_1,port_2_limit_2,port_3_limit_1,port_3_limit_2];
% bw_help1=help1(bw_obstacle,osi_1_x,osi_1_y,radio_px);
% bw_help2=help1(bw_obstacle,osi_2_x,osi_2_y,radio_px);
% bw_help3=help1(bw_obstacle,osi_3_x,osi_3_y,radio_px);
% bw_help=bw_help1|bw_help2|bw_help3;
% arrived_port_number = nnz(bw_port&bw_help);
% limit_can_arrive_port = double(4.5-arrived_port_number)
c=[limit_x_large_than_1,port_limit];
% c=[limit_x_large_than_1,limit_can_arrive_port];
ceq = x-abs(x);