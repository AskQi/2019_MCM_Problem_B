% 输入：无人机编队，ISO编号
% 输出：可否同时满足本ISO服务的医疗点的需求
function flag=PortSupportCheck(RSObox_parame)
A=RSObox_parame(1);
B=RSObox_parame(2);
C=RSObox_parame(3);
D=RSObox_parame(4);
E=RSObox_parame(5);
F=RSObox_parame(6);
G=RSObox_parame(7);
iso_i=RSObox_parame(8);
flag = 1;
% % warning('这里进行了强制输出为1');
if(iso_i>3)
    warning("iso_i错误");
    return;
end
if(iso_i==1)
if(A+B+C+D+E+F+G>0)
else
    flag=0;
end
return;
end
if(iso_i==2)
    if(A+B+D<2&&+C+E+F+G<2)
    flag=0;
    end
    if(A+B+D<5&&A+B+D>=2&&C+E+F+G<1)
    flag=0;
    end
    return;
end
if(iso_i==3)
    if(A+B+C+D+E+F+G>=2)
       
    else
        flag=0;
    end
     return;
end
end