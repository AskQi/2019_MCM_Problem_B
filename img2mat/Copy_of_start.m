clc;
clear;
% workingdir = pwd ;
% imgdir = dir('img*');
% if ~isempty(imgdir.name), cd(imgdir.name), end
% [imgname,imgdir] = uigetfile({'*.jpg';'*.png'},'ѡ��Ҫת����ͼ��')
% if ~imgname
%     cd(workingdir)
%     return
% else
%     cd(imgdir)
% end
% cd(workingdir)
imgname ='rod.jpg';
imgdir ='E:\Important\MatLab\img2mat\imgs\';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

img =imread([imgdir,imgname]);
[M_img,N_img] = size(img);
N_img=N_img/3;
fprintf('ͼƬ�ֱ��ʳߴ磺%dx%d,������%d\n',M_img,N_img,M_img/N_img);
R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);
% ��ɫɸѡ
color_black=R==0 & G==0 & B==0;%��ɫ
color_rod= (R>110&R<180)&(G>90&G<170)&(B>20&B<136);%·
bw = color_rod;
bw = flipud(bw);
% %����ͼƬ
% bw = imresize(bw,0.8);
[M,N] = size(bw);
[bw_left,bw_right,bw_top,bw_bottom]= getBoundary(bw);
bw_height=bw_top-bw_bottom;
bw_weight=bw_right-bw_left;
fprintf('ͼƬ��Ч�ֱ��ʳߴ磺%dx%d,������%d\n',bw_height,bw_weight,bw_height/bw_weight);
fprintf('��ͼ���꣺\nleft��%d, right:%d, top:%d, bottom:%d\n',bw_left,bw_right,bw_top,bw_bottom);


% ����ͼ��
figure
hold on;
for x=1:N
    for y=1:M
       if(bw(y,x)>0)
           plot(x,y,'c.');
       end
    end
end
% imshow(bw);
% hold on;

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
%�������ң������ϣ���������
jingwei_boundary=[
    18,29,20
    17,58,27
    67,10,26
    65,38,56];

jingwei_top=...
    getMinute(jingwei_boundary(1,:));
jingwei_bottom=...
    getMinute(jingwei_boundary(2,:));
jingwei_left=...
    getMinute(jingwei_boundary(3,:)*(-1));
jingwei_right=...
    getMinute(jingwei_boundary(4,:)*(-1));
% ���ڵ��������εģ����Դ�ֱ��ˮƽ�ı����߲�һ����Ӧ�÷ֿ�����
jingwei_bili_weight=bw_weight/(jingwei_right-jingwei_left);
jingwei_bili_height=bw_height/(jingwei_top-jingwei_bottom);
jingwei_port = [
    18.33,-65.65
    18.22,-66.03
    18.44,-66.07
    18.40,-66.16
    18.47,-66.73
    ]*60;
port_jingwei_xiangdui=[jingwei_port(:,2)-jingwei_left,jingwei_port(:,1)-jingwei_bottom];
% jingwei_xiangdui_Caribbean_Medical_Center_Jajardo=port_jingwei_xiangdui(1,:);
% jingwei_xiangdui_Hospital_HIMASan_Pablo=port_jingwei_xiangdui(2,:);
% jingwei_xiangdui_Hospital_Pavia_Santurce_San_Juan=port_jingwei_xiangdui(3,:);
% jingwei_xiangdui_Puerto_Rico_Childrens_Hospital_Bayamon=port_jingwei_xiangdui(4,:);
% jingwei_xiangdui_Hospital_Pavia_AreciboArecibo=port_jingwei_xiangdui(5,:);

port_px_xiangdui = [port_jingwei_xiangdui(:,1)*jingwei_bili_weight,port_jingwei_xiangdui(:,2)*jingwei_bili_height];
% ���Ƶ�
port_px=[port_px_xiangdui(:,1)+bw_left,port_px_xiangdui(:,2)+bw_bottom];
x = port_px(:,1);
y = port_px(:,2);
plot(x,y,'k*');
% port_px=int16([port_px_xiangdui(:,1)+bw_bottom,port_px_xiangdui(:,2)]+bw_left);
% plot(port_px(:,2),port_px(:,1),'r*');

