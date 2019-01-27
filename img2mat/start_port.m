function [port_px]=start_port(bw_left,bw_bottom,jingwei_left,jingwei_bottom,jingwei_bili_height,jingwei_bili_weight)
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
% ªÊ÷∆µ„
port_px=[port_px_xiangdui(:,1)+bw_left,port_px_xiangdui(:,2)+bw_bottom];
end







