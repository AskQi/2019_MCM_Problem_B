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
% [rod_imgname,rod_imgdir] = uigetfile({'*.jpg';'*.png'},'ѡ��Ҫת����ͼ��')
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
% �Ƿ����ͼ��
showpic = true;
%�߽羭γ�������������ң������ϣ���������
jingwei_boundary=[
    18,29,20
    17,58,27
    67,10,26
    65,38,56];
%��������ͼ��
px_resize=[500,1334];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ��ȡ��·��Ϣ
[bw_rod,bw_left,bw_right,bw_top,bw_bottom]=start_rod(rod_imgdir,rod_imgname,px_resize);
[bw_height,bw_weight]= getUseableSize(bw_left,bw_right,bw_top,bw_bottom);
fprintf('��·ͼƬ��Ч�ֱ��ʳߴ磺%dx%d,������%d\n',bw_height,bw_weight,bw_height/bw_weight);
fprintf('��·��ͼ���꣺\nleft��%d, right:%d, top:%d, bottom:%d\n-------------------\n\n',bw_left,bw_right,bw_top,bw_bottom);

% ��ȡ�ϰ���Ϣ
[bw_obstacle,bw_left,bw_right,bw_top,bw_bottom]=start_obstacle(obstacle_imgdir,obstacle_imgname,px_resize);
[bw_height,bw_weight]= getUseableSize(bw_left,bw_right,bw_top,bw_bottom);
fprintf('�ϰ�ͼƬ��Ч�ֱ��ʳߴ磺%dx%d,������%d\n',bw_height,bw_weight,bw_height/bw_weight);
fprintf('�ϰ���ͼ���꣺\nleft��%d, right:%d, top:%d, bottom:%d\n-------------------\n\n',bw_left,bw_right,bw_top,bw_bottom);

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
% ���ڵ��������εģ����Դ�ֱ��ˮƽ�ı����߲�һ����Ӧ�÷ֿ�����
jingwei2px_bili_weight=bw_weight/(jingwei_right-jingwei_left);
jingwei2px_bili_height=bw_height/(jingwei_top-jingwei_bottom);

% ����������
[port_px]=start_port(bw_left,bw_bottom,jingwei_left,jingwei_bottom,jingwei2px_bili_height,jingwei2px_bili_weight);


% ���˻��ܹ������λ��
% help2=help1(bw_obstacle,250,140,220);
[height,width]=size(bw_obstacle);
help2 = helper(height,width,250,140,220);
% ��·�����Թ۲쵽�ĵ���
arrived_rod=bw_rod&help2*flag_rod_arrived;
numebr_of_rod_points = nnz(bw_rod);
numebr_of_arrived_rod_points = nnz(arrived_rod);
proportion_of_arrived_rod_points=numebr_of_arrived_rod_points/numebr_of_rod_points;
fprintf('�����������:\n %d / %d = %s\n',numebr_of_arrived_rod_points,numebr_of_rod_points,proportion_of_arrived_rod_points);

if ~showpic
   return;
end
% ����ͼ��
% imshow(bw);
% hold on;
figure
grid on; %��ʾ������  
axis on; %��ʾ����ϵ 
hold on;
axis equal;
for x=bw_left:bw_right
    for y=bw_bottom:bw_top
       if(bw_rod(y,x)==flag_rod)
           %�����ǹ�·
           plot(x,y,'g.');
       elseif (bw_obstacle(y,x)==flag_moutain_unreachable)
           %�������ϰ�
           plot(x,y,'r.');
%        elseif(help2(y,x)==flag_success_arrived)
%            %�����ǹ�·
%            plot(x,y,'c.');
%        elseif(arrived_rod(y,x)==flag_rod_arrived)
%            %�����Ǳ����յĹ�·
%            plot(x,y,'b.');
%        elseif(help2(y,x)==flag_iso)
%            %������ISO
%            plot(x,y,'ko');
       end
    end
end

% �������ұ߿�
x=ones(numel(bw_bottom-bw_top))*bw_left;
y=bw_bottom:bw_top;
plot(x,y,'-r.');
x=ones(numel(bw_bottom-bw_top))*bw_right;
plot(x,y,'-r.');
% �������±߿�
x=bw_left:bw_right;
y=bw_top;
plot(x,y,'-r.');
y=bw_bottom;
plot(x,y,'-r.');
% ����ҽ�Ƶ� 
x = port_px(:,1);
y = port_px(:,2);
plot(x,y,'-k*');
% �������˻����Ե��������
% for x=1:size(help1,2)
%     for y=1:size(help1,1)
%        if(help1(y,x)==flag_success_arrived)
%            %�����ǹ�·
%            plot(x,y,'c.');
%        end
%     end
% end
