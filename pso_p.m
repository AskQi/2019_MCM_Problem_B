clc;
clear all;
close all force;
global flag_success_arrived flag_moutain_unreachable flag_rod flag_rod_arrived flag_port flag_blank flag_iso
global bw_rod bw_obstacle bw_port bw_help bw_arrived_rod airplane_radios_replace_0_only4limit
global jingwei2px_bili_weight jingwei2px_bili_height jingwei2px_bili
global jingwei2km_bili km2px_bili drug_size drug_number_needs_in_port_daily airplane_radio_px
global f_max f_max_port_not_enough f_max_port_drug_unsupportable f_max_iso_holdable_flag
f_max = 10;
% f_max_port_not_enough=20;
% f_max_port_drug_unsupportable=10;
% f_max_iso_holdable_flag=5;
airplane_radios_replace_0_only4limit = 500;
jingwei2km_bili=11/6;
km2px_bili=15.5*6/11;
flag_moutain_unreachable = -1;
flag_blank = 0;
flag_rod = 1;
flag_success_arrived = 2;
flag_rod_arrived = 3;
flag_port = 4;
flag_iso = 5;
drug_size = [
    14 7 5
    5 8 5
    12 7 4];
drug_number_needs_in_port_daily = [
    1 0 0
    2 1 2
    1 1 0
    2 0 1
    1 0 1
    ];

airplane_radio_km=[
    26.33333333
    9
    7.5
    15.8
    8.533333333];
airplane_radio_px=(km2px_bili*airplane_radio_km)';

final_best_point_bangwan=[462.6 394.99 805.08 216.81 1188.1 462.05 0.89115 0.48607 0.31926 0.13292 0.83688 2.9601 4.9771 4.2538 4.4673 2.4392 1.7509 0.065095 0.36827 1.7168 1.2908 8.0891 3.211 4.185 2.9159 1.3877 0.37072 0.34397 0.039556 1.4039 1.5336 1.5559 7.0905 2.774 7.1587 9.8383 129.03];

final_best_point_gen1=[312.36 335.2 826.78 277.73 1180.2 437.97 0.59096 0.48778 0.2655 0.56043 0.6268 13.894 0 0 0 0 3.1543 0.2916 0.24666 0.2882 1.1142 2.1245 0 0 0 0 0.01037 0.0082883 0.093018 0.65297 0.37866 5.6809 0 0 0 0 13.485];
final_best_point_gen5=[356.53 362.6 870.64 323.12 1151.9 350.69 0.26353 0.27209 0.027771 0.36384 0.95558 3.231 0 0 0 0 1.648 0.2542 0.49601 0.65933 0.82055 10.339 0 0 0 0 1.4349 0.013766 0.24847 0.98436 1.4146 9.873 0 0 0 0 4.9632];

x=final_best_point_gen5;
x=int32(x);
osi_1_x=x(1);
osi_1_y=x(2);
osi_2_x=x(3);
osi_2_y=x(4);
% osi_3_x=x(5)-30;
% osi_3_y=x(6)-20;
osi_3_x=x(5);
osi_3_y=x(6);
osi_1_canshu=[osi_1_x,osi_1_y];
osi_2_canshu=[osi_2_x,osi_2_y];
osi_3_canshu=[osi_3_x,osi_3_y];
iso=[osi_1_canshu;osi_2_canshu;osi_3_canshu];

osi_1_airplane_number_send = int32(x(7:11));
osi_1_airplane_number_scan = int32(x(12:16));
osi_2_airplane_number_send = int32(x(17:21));
osi_2_airplane_number_scan = int32(x(22:26));
osi_3_airplane_number_send = int32(x(27:31));
osi_3_airplane_number_scan = int32(x(32:36));
rescue_time_sum = x(37);

radio_osi_1_scan_km=26.3;
radio_osi_1_scan_px = km2px_bili*radio_osi_1_scan_km;

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


root_dir = pwd ;
rod_imgdir =[root_dir,'\imgs\'];
rod_imgname ='rod.jpg';
obstacle_imgdir =rod_imgdir;
obstacle_imgname ='obstacle.png';
%边界经纬条件：上下左右（北，南，西，东）
jingwei_boundary=[
    18,29,20
    17,58,27
    67,10,26
    65,38,56];
%重新缩放图形
px_resize=[500,1334];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 获取公路信息
[bw_rod,bw_left,bw_right,bw_top,bw_bottom]=start_rod(rod_imgdir,rod_imgname,px_resize);
[bw_height,bw_weight]= getUseableSize(bw_left,bw_right,bw_top,bw_bottom);
fprintf('公路图片有效分辨率尺寸：%dx%d,比例：%d\n',bw_height,bw_weight,bw_height/bw_weight);
fprintf('公路绘图坐标：\nleft：%d, right:%d, top:%d, bottom:%d\n-------------------\n\n',bw_left,bw_right,bw_top,bw_bottom);

% 获取障碍信息
[bw_obstacle,bw_left,bw_right,bw_top,bw_bottom]=start_obstacle(obstacle_imgdir,obstacle_imgname,px_resize);
[bw_height,bw_weight]= getUseableSize(bw_left,bw_right,bw_top,bw_bottom);
fprintf('障碍图片有效分辨率尺寸：%dx%d,比例：%d\n',bw_height,bw_weight,bw_height/bw_weight);
fprintf('障碍绘图坐标：\nleft：%d, right:%d, top:%d, bottom:%d\n-------------------\n\n',bw_left,bw_right,bw_top,bw_bottom);

jingwei_boundary_top=...
    getMinute(jingwei_boundary(1,:));
jingwei_boundary_bottom=...
    getMinute(jingwei_boundary(2,:));
jingwei_boundary_left=...
    getMinute(jingwei_boundary(3,:)*(-1));
jingwei_boundary_right=...
    getMinute(jingwei_boundary(4,:)*(-1));
% 由于地球是球形的，所以垂直和水平的比例尺不一样，应该分开处理。
jingwei2px_bili_weight=bw_weight/(jingwei_boundary_right-jingwei_boundary_left);
jingwei2px_bili_height=bw_height/(jingwei_boundary_top-jingwei_boundary_bottom);
jingwei2px_bili = (jingwei2px_bili_weight+jingwei2px_bili_height)/2;
% 五个点的坐标
[port_px]=start_port(bw_left,bw_bottom,jingwei_boundary_left,jingwei_boundary_bottom,jingwei2px_bili_height,jingwei2px_bili_weight);
port_px=int32(port_px);
bw_port = zeros(px_resize);
for x=1:size(port_px,1)
    bw_port(port_px(x,2),port_px(x,1))=flag_port;
end

[height,width]=size(bw_obstacle);
% 侦查无人机能够到达的位置
bw_help1 = helper(height,width,osi_1_x,osi_1_y,radio_osi_1_scan_px);
bw_help2 = helper(height,width,osi_2_x,osi_2_y,radio_osi_1_scan_px);
bw_help3 = helper(height,width,osi_3_x,osi_3_y,radio_osi_1_scan_px);
bw_help=bw_help1|bw_help2|bw_help3;
arrived_port_number = nnz(bw_port&bw_help);
limit_can_arrive_port = arrived_port_number>=5;
fprintf('到达Port: %d\n',arrived_port_number);
% 绘制图形
% imshow(bw);
% hold on;
figure
grid on; %显示网格线
axis on; %显示坐标系
hold on;
axis equal;
for x=1:1334
    for y=1:500
        if(bw_rod(y,x)==flag_rod)
            %这里是公路
            plot(x,y,'g.');
        elseif (bw_obstacle(y,x)==flag_moutain_unreachable)
            %这里是障碍
            plot(x,y,'r.');
            %             elseif(bw_help(y,x)==flag_success_arrived)
            %                 %这里是公路
            %                 plot(x,y,'c.');
            %             elseif(bw_arrived_rod(y,x)==flag_rod_arrived)
            %                 %这里是被拍到的公路
            %                 plot(x,y,'b.');
            %             elseif(bw_port(y,x)==flag_port)
            %                 %这里是五点坐标
            %                 plot(x,y,'-k*');
        end
    end
end
% 绘制左右边框
x=ones(numel(bw_bottom-bw_top))*bw_left;
y=bw_bottom:bw_top;
plot(x,y,'-r.');
x=ones(numel(bw_bottom-bw_top))*bw_right;
plot(x,y,'-r.');
% 绘制上下边框
x=bw_left:bw_right;
y=bw_top;
plot(x,y,'-r.');
y=bw_bottom;
plot(x,y,'-r.');
% 绘制医疗点
x = port_px(:,1);
y = port_px(:,2);
plot(x,y,'k*');


for iso_i = 1:3
    x0=double(iso(iso_i,1));
    y0=double(iso(iso_i,2));
    r=radio_osi_1_scan_px;
    theta=0:pi/50:2*pi;
    x=x0+r*cos(theta);
    y=y0+r*sin(theta);
    plot(x,y,'-',x0,y0,'o');
end


