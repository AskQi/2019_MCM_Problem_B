function [left,right,top,bottom]= getObstacleBoundary(bw)
[M,N] = size(bw);
left=1;
right=N;
top=M;
bottom=1;
end