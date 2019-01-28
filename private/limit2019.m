function [c, ceq] = limit2019(x)
global km2px_bili bw_obstacle bw_port airplane_radio_px
global drug_number_needs_in_port_daily airplane_radios_replace_0_only4limit
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
failed_c=ones(12,1);
%这里是开关
enable_port_scan_arrival_limit = 1;
enable_port_send_arrival_limit = 1;
enable_more_limit = 1;

if enable_port_scan_arrival_limit
    port_1_scan_limit = norm(port_1-osi_1_canshu)-radio_osi_1_scan_px;
    port_2_scan_limit_1 = norm(port_2-osi_2_canshu)-radio_osi_1_scan_px;
    port_2_scan_limit_2 = norm(port_4-osi_2_canshu)-radio_osi_1_scan_px;
    port_3_scan_limit_1 = norm(port_3-osi_3_canshu)-radio_osi_1_scan_px;
    port_3_scan_limit_2 = norm(port_5-osi_3_canshu)-radio_osi_1_scan_px;
    port_scan_arrival_limit = [port_1_scan_limit,port_2_scan_limit_1,port_2_scan_limit_2,port_3_scan_limit_1,port_3_scan_limit_2];
    if max(port_scan_arrival_limit)>0
                c=failed_c;
                ceq=[];
                return;
    else
%         disp(port_scan_arrival_limit);
    end
else
    port_scan_arrival_limit = ones(5,1)*-1;
end

all_send_airplane_types=osi_airplane_number_send>0;
% all_send_airplane_radios=zeros(size(all_send_airplane_types));
airplane_radio_bw_px=[
    airplane_radio_px
    airplane_radio_px
    airplane_radio_px];
all_send_airplane_radios = airplane_radio_bw_px.*all_send_airplane_types;

if enable_port_send_arrival_limit
    all_send_airplane_radios_not_really_only4limimt=all_send_airplane_radios+(osi_airplane_number_send==0)*airplane_radios_replace_0_only4limit;
    port_1_send_limit = norm(port_1-osi_1_canshu)-min(all_send_airplane_radios_not_really_only4limimt(:,1));
    port_2_send_limit_1 = norm(port_2-osi_2_canshu)-min(all_send_airplane_radios_not_really_only4limimt(:,2));
    port_2_send_limit_2 = norm(port_4-osi_2_canshu)-min(all_send_airplane_radios_not_really_only4limimt(:,2));
    port_3_send_limit_1 = norm(port_3-osi_3_canshu)-min(all_send_airplane_radios_not_really_only4limimt(:,3));
    port_3_send_limit_2 = norm(port_5-osi_3_canshu)-min(all_send_airplane_radios_not_really_only4limimt(:,3));
    port_send_arrival_limit = [port_1_send_limit,port_2_send_limit_1,port_2_send_limit_2,port_3_send_limit_1,port_3_send_limit_2];
    if max(port_send_arrival_limit)>0
                c=failed_c;
                ceq=[];
                return;
    else
%         disp(port_send_arrival_limit);
    end
else
    port_send_arrival_limit = ones(5,1)*-1;
end


if enable_more_limit
    osi_1_airplane_number=osi_airplane_number_scan+osi_airplane_number_send;
    A=[0;0;0;];
    BC=osi_1_airplane_number(:,1:2);
    D=[0;0;0;];
    EFG=osi_1_airplane_number(:,3:5);
    % M1,M2,M3是在ISO点的各个药品的总数量（所有天）
    drug_number_in_iso_1=drug_number_needs_in_port_daily(1,:);
    drug_number_in_iso_2=drug_number_needs_in_port_daily(2,:)+drug_number_needs_in_port_daily(4,:);
    drug_number_in_iso_3=drug_number_needs_in_port_daily(3,:)++drug_number_needs_in_port_daily(5,:);
    drug_number_in_iso=[drug_number_in_iso_1;drug_number_in_iso_2;drug_number_in_iso_3];
    M=drug_number_in_iso;
    % G1,G2为篮子的个数
    G1=osi_1_airplane_number(:,1);
    G2=sum(osi_1_airplane_number(:,2:5),2);
    RSObox_parame=[A,BC,D,EFG,M,G1,G2];
    iso_holdable_flag=1;
    for iso_i=1:3
        this_RSObox_parame = RSObox_parame(iso_i,:);
        %这个ISO点是否能够盛下所有的东西
        iso_i_holdable_flag=RSObox(this_RSObox_parame);
        if iso_i_holdable_flag == 0
            iso_holdable_flag = 0;
%             disp(this_RSObox_parame);
            break;
        end
    end
    port_drug_supportable_flag=1;
    for iso_i=1:3
        %这个ISO配置是否能够满足服务的医疗点的问题
        this_RSObox_parame = RSObox_parame(iso_i,:);
        this_PortSupportCheck_parame = [this_RSObox_parame(1:7),iso_i];
        iso_i_port_drug_supportable_flag=PortSupportCheck(this_PortSupportCheck_parame);
        if iso_i_port_drug_supportable_flag == 0
            port_drug_supportable_flag = 0;
%             disp(this_PortSupportCheck_parame);
            break;
        end
    end
    iso_holdable_limit = 0.5-iso_holdable_flag;
    port_drug_supportable_flag = 0.5-port_drug_supportable_flag;
else
    iso_holdable_limit=-1;
    port_drug_supportable_flag=-1;
end
c=[port_scan_arrival_limit,port_send_arrival_limit,iso_holdable_limit,port_drug_supportable_flag];
% c=[limit_x_large_than_1,port_send_arrival_limit,iso_holdable_limit,port_drug_supportable_flag];
if max(c)<0
    disp(c);
end
% c=[limit_x_large_than_1,port_scan_arrival_limit,port_send_arrival_limit,iso_holdable_limit];
% ceq:x>0
ceq = [];