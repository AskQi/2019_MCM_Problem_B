function [bw,bw_left,bw_right,bw_top,bw_bottom]=start_rod(imgdir,imgname,px_resize)
global flag_rod
img =imread([imgdir,imgname]);
[M_img,N_img] = size(img);
N_img=N_img/3;
fprintf('ͼƬ�ֱ��ʳߴ磺%dx%d,������%d\n',M_img,N_img,M_img/N_img);
R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);
% ��ɫɸѡ
color_rod= (R>110&R<180)&(G>90&G<170)&(B>20&B<136);%·
bw = color_rod;
bw = flipud(bw);
% ��·Ϊ1
bw=int8(bw)*flag_rod;
[bw_left,bw_right,bw_top,bw_bottom]= getBoundary(bw);
bw=bw(bw_bottom:bw_top,bw_left:bw_right);
% %����ͼƬ
bw = imresize(bw,px_resize);
[bw_left,bw_right,bw_top,bw_bottom]= getBoundary(bw);
end







