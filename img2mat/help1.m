function M=help1(M,X_s,Y_s,radio)
%%flag=0救援失败，flag=1救援成功，photo为目标函数（越大越好）,X_s,Y_s为出发前的位置,step为步长,radio为最长半径。
global flag_success_arrived flag_moutain_unreachable
step=radio;
M=int8(M);
[L,W]=size(M);
if X_s<1 ||X_s>W
    M = zeros(L,W);
    return;
end
if Y_s<1 ||Y_s>L
    M = zeros(L,W);
    return;
end
MAX=L*W;
temp=X_s;
X_s=Y_s;
Y_s=temp;
%flag=0;
sM=M;
for j=1:3
P=find(sM==1);
    for i=1:length(P)
        if(P(i)+L*1<=MAX)
            sM(P(i)+L*1)=flag_moutain_unreachable ;
            sM(P(i)+L*1-1)=flag_moutain_unreachable ;
            if(P(i)+L*1+1<=MAX)
                sM(P(i)+L*1+1)=flag_moutain_unreachable ;
            end
        end
        if(P(i)-L*1>0)
            sM(P(i)-L*1)=flag_moutain_unreachable ;
            M(P(i)-L*1+1)=flag_moutain_unreachable ;
            if(P(i)-L*1-1>0)
                sM(P(i)-L*1-1)=flag_moutain_unreachable ;
            end
        end
        if(P(i)-1>0)
            sM(P(i)-1)=flag_moutain_unreachable ;
        end
        if(P(i)+1<=MAX)
            sM(P(i)+1)=flag_moutain_unreachable ;
        end
    end
end





M(X_s,Y_s)=flag_success_arrived ;
for j=1:step
    P=find(M==flag_success_arrived );
    for i=1:length(P)
        if(P(i)+L*1<=MAX)
            M(P(i)+L*1)=flag_success_arrived ;
            M(P(i)+L*1-1)=flag_success_arrived ;
            if(P(i)+L*1+1<=MAX)
                M(P(i)+L*1+1)=flag_success_arrived ;
            end
        end
        if(P(i)-L*1>0)
            M(P(i)-L*1)=flag_success_arrived ;
            M(P(i)-L*1+1)=flag_success_arrived ;
            if(P(i)-L*1-1>0)
                M(P(i)-L*1-1)=flag_success_arrived ;
            end
        end
        if(P(i)-1>0)
            M(P(i)-1)=flag_success_arrived ;
        end
        if(P(i)+1<=MAX)
            M(P(i)+1)=flag_success_arrived ;
        end
    end
    M=M.*(1-sM)+sM;
end
P=find(M==flag_success_arrived );
for i=1:length(P)
    y=floor(double((P(i)/L)));
    x=P(i)-L*y;
    y=y+1;
    long=(x-X_s)^2+(y-Y_s)^2;
    if(long>radio^2)
        M(P(i))=0;
    end
end
M=(M+1).*M/3;
end