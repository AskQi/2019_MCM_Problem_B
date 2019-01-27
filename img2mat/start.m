clc;
clear;
global flag_success_arrived flag_moutain_unreachable flag_rod flag_rod_arrived flag_iso
flag_moutain_unreachable = -1;
flag_rod = 1;
flag_success_arrived = 2;
flag_rod_arrived = 3;
flag_iso = 5;
% workingdir = imgs ;
% rod_imgdir = dir('img*');
% if ~isempty(rod_imgdir.name), cd(rod_imgdir.name), end
% [rod_imgname,rod_imgdir] = uigetfile({'*.jpg';'*.png'},'选择要转换的图像')
% if ~rod_imgname
%     cd(workingdir)
%     return
% else
%     cd(rod_imgdir)
% end
% cd(workingdir)

rod_imgdir ='E:\Important\MatLab\2019\img2mat\imgs\';
rod_imgname ='rod.jpg';
obstacle_imgdir =rod_imgdir;
obstacle_imgname ='obstacle.png';
% 是否绘制图形
showpic = true;
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

% bw=(1+bw_obstacle).*bw_rod+bw_obstacle;
bw = bw_obstacle + bw_rod;

jingwei_top=...
    getMinute(jingwei_boundary(1,:));
jingwei_bottom=...
    getMinute(jingwei_boundary(2,:));
jingwei_left=...
    getMinute(jingwei_boundary(3,:)*(-1));
jingwei_right=...
    getMinute(jingwei_boundary(4,:)*(-1));
% 由于地球是球形的，所以垂直和水平的比例尺不一样，应该分开处理。
jingwei2px_bili_weight=bw_weight/(jingwei_right-jingwei_left);
jingwei2px_bili_height=bw_height/(jingwei_top-jingwei_bottom);

% 五个点的坐标
[port_px]=start_port(bw_left,bw_bottom,jingwei_left,jingwei_bottom,jingwei2px_bili_height,jingwei2px_bili_weight);


% 无人机能够到达的位置
% help2=help1(bw_obstacle,250,140,220);
[height,width]=size(bw_obstacle);
help2 = helper(height,width,250,140,220);
% 该路径可以观察到的点数
arrived_rod=bw_rod&help2*flag_rod_arrived;
numebr_of_rod_points = nnz(bw_rod);
numebr_of_arrived_rod_points = nnz(arrived_rod);
proportion_of_arrived_rod_points=numebr_of_arrived_rod_points/numebr_of_rod_points;
fprintf('到达点数比例:\n %d / %d = %s\n',numebr_of_arrived_rod_points,numebr_of_rod_points,proportion_of_arrived_rod_points);

if ~showpic
   return;
end
% 绘制图形
% imshow(bw);
% hold on;
figure
grid on; %显示网格线  
axis on; %显示坐标系 
hold on;
axis equal;
for x=bw_left:bw_right
    for y=bw_bottom:bw_top
       if(bw_rod(y,x)==flag_rod)
           %这里是公路
           plot(x,y,'g.');
       elseif (bw_obstacle(y,x)==flag_moutain_unreachable)
           %这里是障碍
           plot(x,y,'r.');
%        elseif(help2(y,x)==flag_success_arrived)
%            %这里是公路
%            plot(x,y,'c.');
%        elseif(arrived_rod(y,x)==flag_rod_arrived)
%            %这里是被拍照的公路
%            plot(x,y,'b.');
%        elseif(help2(y,x)==flag_iso)
%            %这里是ISO
%            plot(x,y,'ko');
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
plot(x,y,'-k*');
% 绘制无人机可以到达的区域
% for x=1:size(help1,2)
%     for y=1:size(help1,1)
%        if(help1(y,x)==flag_success_arrived)
%            %这里是公路
%            plot(x,y,'c.');
%        end
%     end
% end
