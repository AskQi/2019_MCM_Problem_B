function [bw,bw_left,bw_right,bw_top,bw_bottom]=start_obstacle(imgdir,imgname,px_resize)
global flag_moutain_unreachable
img =imread([imgdir,imgname]);
% 图片预处理
h=[1,2,1;0,0,0;-1,-2,-1];
% img=filter2(h,img)

[M_img,N_img] = size(img);
N_img=N_img/3;
fprintf('图片分辨率尺寸：%dx%d,比例：%d\n',M_img,N_img,M_img/N_img);
R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);
% 颜色筛选
color_black=R==0 & G==0 & B==0;%黑色
bw = color_black;
% 滤波处理
bw = medfilt2(bw);
% 障碍为-1
bw=flag_moutain_unreachable*int8(bw);
bw = flipud(bw);
% %缩放图片
bw = imresize(bw,px_resize);
[bw_left,bw_right,bw_top,bw_bottom]= getObstacleBoundary(bw);
end