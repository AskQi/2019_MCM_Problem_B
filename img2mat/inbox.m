function flag=inbox(LENGTH,flag,BR)
%%ABCDEFG为无人机的数量，M1M2M3为药品的数量
%%BR为12维数组。
%%   长    宽    高    体积  (in.)   最大底面积
%%OSI  231  92    94          1997688
%%A   45    45    25           50625    2025
%%B   30    30    22           19800    900
%%C   60    50    30           90000    3000
%%D   25    20    25           12500    625
%%E   25    20    27           13500    675
%%F   40    40    25           40000    1600
%%G   32    32    17           17408    1024
%%M1  14    7     5             490     98
%%M2  5     8     5             200     40
%%M3  12    7     4             336     84
%%G1   8    10    14            1120    140
%%G2   24   20    20            9600    480
%%优先级排列C>A>F>G>B>E>D>G2>G1>M1>M3>M2
L=[60,45,40,30,32,25,25,24,8,14,12,5];
W=[50,45,40,30,32,20,20,20,10,7,7,8];
H=[30,25,25,22,17,27,25,20,14,5,4,5];
V_0=[9000,50625,40000,17408,19800,13500,12500,9600,1120,490,336,200];
if(flag==-1)
    flag=1;
    LENGTH=[231,92,94];
end
if(flag==0)
    return;
elseif(max(BR)==0)
    return
else
    i=find(BR~=0);
    i=i(1);
    BR(i)=BR(i)-1;
    V=LENGTH(:,1).*LENGTH(:,2).*LENGTH(:,3);
    if(max(V)<V_0(i))
        flag=0;
    else
        j=find(V-V_0(i)>=0);
        j=find(V==min(V(j)));
        LENGTH0=LENGTH([1:j-1,j+1:end],:);
        if(LENGTH(j,1)>=L(i))&&(LENGTH(j,2)>=W(i))&&(LENGTH(j,3)>=H(i))
        LENGTH1=[LENGTH0;LENGTH(j,1)-L(i),LENGTH(j,2)-W(i),LENGTH(j,3)-H(i)];
        flag1=inbox(LENGTH1,flag,BR);
        else
            flag1=0;
        end
       
        if(LENGTH(j,1)-L(i)>0&&LENGTH(j,2)-H(i)>=0&&LENGTH(j,3)-W(i)>=0)
        LENGTH2=[LENGTH0;LENGTH(j,1)-L(i),LENGTH(j,2)-H(i),LENGTH(j,3)-W(i)];
        flag2=inbox(LENGTH2,flag,BR);
        else
            flag2=0;
        end
        if(LENGTH(j,1)-H(i)>0&&LENGTH(j,2)-W(i)>=0&&LENGTH(j,3)-L(i)>=0)
        LENGTH3=[LENGTH0;LENGTH(j,1)-H(i),LENGTH(j,2)-W(i),LENGTH(j,3)-L(i)];
        flag3=inbox(LENGTH3,flag,BR);
        else
            flag3=0;
        end
        if(LENGTH(j,1)-L(i)>0&&LENGTH(j,2)-W(i)>=0&&LENGTH(j,3)-H(i)>=0)
        LENGTH4=[LENGTH0;LENGTH(j,1)-W(i),LENGTH(j,2)-H(i),LENGTH(j,3)-L(i)];
        flag4=inbox(LENGTH4,flag,BR);
        else
            flag4=0;
        end
        if(LENGTH(j,1)-H(i)>0&&LENGTH(j,2)-L(i)>=0&&LENGTH(j,3)-W(i)>=0)
        LENGTH5=[LENGTH0;LENGTH(j,1)-H(i),LENGTH(j,2)-L(i),LENGTH(j,3)-W(i)];
        flag5=inbox(LENGTH5,flag,BR);
        else
            flag5=0;
        end
        if(LENGTH(j,1)-W(i)>0&&LENGTH(j,2)-L(i)>=0&&LENGTH(j,3)-H(i)>=0)
        LENGTH6=[LENGTH0;LENGTH(j,1)-W(i),LENGTH(j,2)-L(i),LENGTH(j,2)-H(i)];
        flag6=inbox(LENGTH6,flag,BR);
        else
            flag6=0;
        end
        if(flag1+flag2+flag3+flag4+flag5+flag6>0)
                flag=1;
        end
    end
end

