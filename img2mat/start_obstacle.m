function [bw,bw_left,bw_right,bw_top,bw_bottom]=start_obstacle(imgdir,imgname,px_resize)
global flag_moutain_unreachable
img =imread([imgdir,imgname]);
% ͼƬԤ����
h=[1,2,1;0,0,0;-1,-2,-1];
% img=filter2(h,img)

[M_img,N_img] = size(img);
N_img=N_img/3;
fprintf('ͼƬ�ֱ��ʳߴ磺%dx%d,������%d\n',M_img,N_img,M_img/N_img);
R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);
% ��ɫɸѡ
color_black=R==0 & G==0 & B==0;%��ɫ
bw = color_black;
% �˲�����
bw = medfilt2(bw);
% �ϰ�Ϊ-1
bw=flag_moutain_unreachable*int8(bw);
bw = flipud(bw);
% %����ͼƬ
bw = imresize(bw,px_resize);
[bw_left,bw_right,bw_top,bw_bottom]= getObstacleBoundary(bw);
end