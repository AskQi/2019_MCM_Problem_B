function flag=OSI_supply(M1,M2,M3,DEMAND,i)
%%DEMAND=[
%%       1 0 0
%%       2 1 2
%%       1 1 0
%%       2 0 1
%%       1 0 1
%%              ]
if(i==1)
    %ÅäÖÃ£ºPROT1
    if(M1>=DEMAND(1,1)&&M2>=DEMAND(1,2)&&M3>=DEMAND(1,3))
        flag=1;
    else
        flag=0;
    end
end
if(i==2)
    %ÅäÖÃ£ºPROT2 PROT4
    if(M1>=DEMAND(2,1)+DEMAND(4,1)&&M2>=DEMAND(2,2)+DEMAND(4,2)&&M3>=DEMAND(2,3)+DEMAND(4,3))
        flag=1;
    else
        flag=0;
    end
end
if(i==3)
    %ÅäÖÃ£ºPROT3 PROT5
    if(M1>=DEMAND(3,1)+DEMAND(5,1)&&M2>=DEMAND(3,2)+DEMAND(5,2)&&M3>=DEMAND(3,3)+DEMAND(5,3))
        flag=1;
    else
        flag=0;
    end
end
