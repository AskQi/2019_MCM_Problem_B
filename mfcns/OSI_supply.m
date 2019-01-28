function flag=OSI_supply(parame)
DEMAND=[
    1 0 0
    2 1 2
    1 1 0
    2 0 1
    1 0 1
    ];
M1=parame(1);
M2=parame(2);
M3=parame(3);
i=parame(4);
T=parame(5);

if(i==1)
    %??????PROT1
    if(M1>=DEMAND(1,1)*T&&M2>=DEMAND(1,2)*T&&M3>=DEMAND(1,3)*T)
        flag=1;
    else
        flag=0;
    end
end
if(i==2)
    %??????PROT2 PROT4
    if(M1>=DEMAND(2,1)*T+DEMAND(4,1)*T&&M2>=DEMAND(2,2)*T+DEMAND(4,2)*T&&M3>=DEMAND(2,3)*T+DEMAND(4,3)*T)
        flag=1;
    else
        flag=0;
    end
end
if(i==3)
    %??????PROT3 PROT5
    if(M1>=DEMAND(3,1)*T+DEMAND(5,1)*T&&M2>=DEMAND(3,2)*T+DEMAND(5,2)*T&&M3>=DEMAND(3,3)*T+DEMAND(5,3)*T)
        flag=1;
    else
        flag=0;
    end
end
