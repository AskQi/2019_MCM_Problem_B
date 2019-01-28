function averdis=getwrok(M_road,X,Y,radio,L_road,num)
[width,height]=size(M_road);
W=helper(width,height,X,Y,radio);
M_inroad=W.*M_road;
M_dis=zeros(size(M_road));
[x_p,y_p]=find(M_inroad==1);
for i=1:length(x_p)
    M_dis(x_p(i),y_p(i))=norm([x_p(i),y_p(i)]-[X,Y]);
end
averdis=sum(sum(M_dis))/sum(sum(M_inroad));
averdis=averdis*num;