% ���룺���˻���ӣ�ISO���
% ������ɷ�ͬʱ���㱾ISO�����ҽ�Ƶ������
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
% % warning('���������ǿ�����Ϊ1');
if(iso_i>3)
    warning('iso_i����');
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