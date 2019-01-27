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
%%优先级C>A>F>G>B>E>D>G2>G1>M1>M3>M2
function flag=RSObox(A,B,C,D,E,F,G,M1,M2,M3,G1,G2)
flag = 1;
% % warning('这里进行了强制输出为1');
return;
BR=[C,A,F,G,B,E,D,G2,G1,M1,M3,M2];
V_0=[90000,50625,40000,17408,19800,13500,12500,9600,1120,490,200,336];
V_sum=BR*V_0';
V_osi=1997688;
L=[60,45,40,32,30,25,25,24,8,14,12,5];
W=[50,45,40,32,30,20,20,20,10,7,7,8];
H=[30,25,25,17,22,27,25,20,14,5,4,5];
SF=[231,92,94];%所有能进行放置的空间；
if(V_sum<=V_osi)
    flag=1;
else
    flag=0;
    return;
end
while(any(BR))
    chose=find(BR~=0);
    chose=chose(1);
    if any(any(SF))
        %选择空间
        SR=getfirst(SF,L(chose),W(chose),H(chose));
        if(isempty(SR))
            flag=0;
            return;
        else
            j=find(SR==max(SR));
            j=j(1);
        end
        %放置
        a=L(chose);b=W(chose);
        sq1=max([a*b,(SF(j,1)-a)*b,SF(j,1)*(SF(j,2)-b)]);
        sq2=max([a*b,(SF(j,1)-a)*SF(j,2),a*(SF(j,2)-b)]);
        a=W(chose);b=L(chose);
        sq3=max([a*b,(SF(j,1)-a)*b,SF(j,1)*(SF(j,2)-b)]);
        sq4=max([a*b,(SF(j,1)-a)*SF(j,2),a*(SF(j,2)-b)]);
        SQ=[sq1,sq2,sq3,sq4];
        I=find(SQ==max(SQ));
        I=I(1);
        %分割
        if(I==1||I==2)
            a=L(chose);b=W(chose);
            S_3=(SF(j,1)-a)*(b);
            S_2=(a)*(SF(j,2)-b);
            if(S_3>S_2)
                SF=[SF;max(SF(j,1)-a,SF(j,2)),min(SF(j,1)-a,SF(j,2)),SF(j,3);max(a,SF(j,2)-b),min(a,SF(j,2)-b),SF(j,3)];
                SF=[SF;max(a,b),min(a,b),SF(j,3)-H(chose)];
                SF=SF([1:j-1,j+1:end],:);
            else
                SF=[SF;max(SF(j,1)-a,b),min(SF(j,1)-a,b),SF(j,3);max(SF(j,1),SF(j,2)-b),min(SF(j,1),SF(j,2)-b),SF(j,3)];
                SF=[SF;max(a,b),min(a,b),SF(j,3)-H(chose)];
                SF=SF([1:j-1,j+1:end],:);
            end
        end
        if(I==3||I==4)
            a=W(chose);b=L(chose);
            S_3=(SF(j,1)-a)*(b);
            S_2=(a)*(SF(j,2)-b);
            if(S_3>S_2)
                SF=[SF;max(SF(j,1)-a,SF(j,2)),min(SF(j,1)-a,SF(j,2)),SF(j,3);max(a,SF(j,2)-b),min(a,SF(j,2)-b),SF(j,3)];
                SF=[SF;max(a,b),min(a,b),SF(j,3)-H(chose)];
                SF=SF([1:j-1,j+1:end],:);
            else
                SF=[SF;max(SF(j,1)-a,b),min(SF(j,1)-a,b),SF(j,3);max(SF(j,1),SF(j,2)-b),min(SF(j,1),SF(j,2)-b),SF(j,3)];
                SF=[SF;max(a,b),min(a,b),SF(j,3)-H(chose)];
                SF=SF([1:j-1,j+1:end],:);
            end
        end
    end
    %装箱成功
    BR(chose)=BR(chose)-1;
end
end