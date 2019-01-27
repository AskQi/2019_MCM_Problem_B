function [c, ceq] = limit2019(x)
global km2px_bili bw_obstacle bw_port airplane_radio_px drug_number_in_port
%非线性约束
% fprintf('limits\n');
limit_x_large_than_1 = 1-x;
% x=int32(x);
radio_osi_1_scan_km=26.3;
radio_osi_1_scan_px = km2px_bili*radio_osi_1_scan_km;
% % 无人机能够到达的位置
osi_1_x=x(1);
osi_1_y=x(2);
osi_2_x=x(3);
osi_2_y=x(4);
osi_3_x=x(5);
osi_3_y=x(6);
osi_1_canshu=[osi_1_x,osi_1_y];
osi_2_canshu=[osi_2_x,osi_2_y];
osi_3_canshu=[osi_3_x,osi_3_y];

osi_1_airplane_number_send = int32(x(7:11));
osi_1_airplane_number_scan = int32(x(12:16));
osi_2_airplane_number_send = int32(x(17:21));
osi_2_airplane_number_scan = int32(x(22:26));
osi_3_airplane_number_send = int32(x(27:31));
osi_3_airplane_number_scan = int32(x(32:36));
osi_airplane_number_send=[
    osi_1_airplane_number_send
    osi_2_airplane_number_send
    osi_3_airplane_number_send];
osi_airplane_number_scan=[
    osi_1_airplane_number_scan
    osi_2_airplane_number_scan
    osi_3_airplane_number_scan];
port_1=[389 483];
port_2=[888 415];
port_3=[966 453];
port_4=[1002 240];
port_5=[1334 346];

port_1_scan_limit = norm(port_1-osi_1_canshu)-radio_osi_1_scan_px;
port_2_scan_limit_1 = norm(port_2-osi_2_canshu)-radio_osi_1_scan_px;
port_2_scan_limit_2 = norm(port_4-osi_2_canshu)-radio_osi_1_scan_px;
port_3_scan_limit_1 = norm(port_3-osi_3_canshu)-radio_osi_1_scan_px;
port_3_scan_limit_2 = norm(port_5-osi_3_canshu)-radio_osi_1_scan_px;
port_scan_arrival_limit = [port_1_scan_limit,port_2_scan_limit_1,port_2_scan_limit_2,port_3_scan_limit_1,port_3_scan_limit_2];
all_send_airplane_types=osi_airplane_number_send>0;
% all_send_airplane_radios=zeros(size(all_send_airplane_types));
airplane_radio_bw_px=[
    airplane_radio_px
    airplane_radio_px
    airplane_radio_px];
all_send_airplane_radios = airplane_radio_bw_px.*all_send_airplane_types;
port_1_send_limit = norm(port_1-osi_1_canshu)-max(all_send_airplane_radios(:,1));
port_2_send_limit_1 = norm(port_2-osi_2_canshu)-max(all_send_airplane_radios(:,2));
port_2_send_limit_2 = norm(port_4-osi_2_canshu)-max(all_send_airplane_radios(:,2));
port_3_send_limit_1 = norm(port_3-osi_3_canshu)-max(all_send_airplane_radios(:,3));
port_3_send_limit_2 = norm(port_5-osi_3_canshu)-max(all_send_airplane_radios(:,3));
port_send_arrival_limit = [port_1_send_limit,port_2_send_limit_1,port_2_send_limit_2,port_3_send_limit_1,port_3_send_limit_2];

% all_send_airplane_radios_pingfang-(all_send_airplane_radios>0)*
% port_1_send_arrival_limit=
% port_send_arrival_limit
osi_1_airplane_number=osi_airplane_number_scan+osi_airplane_number_send;
A=[0;0;0;];
BC=osi_1_airplane_number(:,1:2);
D=[0;0;0;];
EFG=osi_1_airplane_number(:,3:5);
% M1,M2,M3是在ISO点的各个药品的总数量（所有天）
drug_number_in_iso_1=drug_number_in_port(1,:);
drug_number_in_iso_2=drug_number_in_port(2,:)+drug_number_in_port(4,:);
drug_number_in_iso_3=drug_number_in_port(3,:)++drug_number_in_port(5,:);
drug_number_in_iso=[drug_number_in_iso_1;drug_number_in_iso_2;drug_number_in_iso_3];
M=drug_number_in_iso;
% G1,G2为篮子的个数
G1=osi_1_airplane_number(:,1);
G2=sum(osi_1_airplane_number(:,2:5),2);
RSObox_parame=[A,BC,D,EFG,M,G1,G2];
iso_holdable_flag=1;
for osi_i=1:3
    this_RSObox_parame = RSObox_parame(osi_i,:);
    iso_i_holdable_flag=RSObox(this_RSObox_parame);
    if iso_i_holdable_flag == 0
        iso_holdable_flag = 0;
        break;
    end
end
iso_holdable_limit = 0.5-iso_holdable_flag;
c=[limit_x_large_than_1,port_scan_arrival_limit,port_send_arrival_limit,iso_holdable_limit];
ceq = x-abs(x);