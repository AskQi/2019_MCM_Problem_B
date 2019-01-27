function [bw,bw_left,bw_right,bw_top,bw_bottom]=start_rod(imgdir,imgname,px_resize)
global flag_rod
img =imread([imgdir,imgname]);
[M_img,N_img] = size(img);
N_img=N_img/3;
fprintf('图片分辨率尺寸：%dx%d,比例：%d\n',M_img,N_img,M_img/N_img);
R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);
% 颜色筛选
color_rod= (R>110&R<180)&(G>90&G<170)&(B>20&B<136);%路
bw = color_rod;
bw = flipud(bw);
% 道路为1
bw=int8(bw)*flag_rod;
[bw_left,bw_right,bw_top,bw_bottom]= getBoundary(bw);
bw=bw(bw_bottom:bw_top,bw_left:bw_right);
% %缩放图片
bw = imresize(bw,px_resize);
[bw_left,bw_right,bw_top,bw_bottom]= getBoundary(bw);
end







