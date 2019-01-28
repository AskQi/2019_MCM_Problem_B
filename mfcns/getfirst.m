function M=getfirst(SF,L,W,H)
apha=0.1;
I=[];
M=[];
for j=1:size(SF,1)
    if(SF(j,1)>L&&SF(j,2)>W&&SF(j,3)>H)
    I=[I j];
    end
end
for i=I
M=[M,-(SF(i,1)-L+apha)*(SF(i,2)-W+apha)];
end