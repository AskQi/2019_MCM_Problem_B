function M=helper(height,width,x_center,y_center,radio)
%%height为行,width为列，xy为坐标，radio为半径，flag为圆内值，圆外值为0;
global flag_success_arrived flag_blank flag_iso
M=zeros(height,width);
for i=max(y_center-radio,1):min(y_center+radio,height)
for j=max(x_center-radio,1):min(x_center+radio,width)
    M(i,j) =(i-y_center)^2+(j-x_center)^2;
end
end
I=M<=radio^2&M>0;
J=M>radio^2;
M(I)=flag_success_arrived;
M(J)=flag_blank;
% M(y_center,x_center)=flag_iso;
end