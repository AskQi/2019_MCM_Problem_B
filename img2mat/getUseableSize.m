function [bw_height,bw_weight]= getUseableSize(bw_left,bw_right,bw_top,bw_bottom)
bw_height=bw_top-bw_bottom+1;
bw_weight=bw_right-bw_left+1;
end