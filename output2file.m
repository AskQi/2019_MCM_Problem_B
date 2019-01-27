function f = output2file(x)
global S_w S_g S_mw K_m
nowtime = datestr(now,31);
if strcmp(x,'begin')
    output_notice=['Start a new record at ',nowtime,''];
    dlmwrite('bestpoints.txt', output_notice,'-append','delimiter', '','newline', 'pc');
elseif strcmp(x,'end')
    output_notice=['Record end at ',nowtime,''];
    dlmwrite('bestpoints.txt', output_notice,'-append','delimiter', '','newline', 'pc');
   
elseif strcmp(x,'S_w')
    output_notice=['-------------Rand S_w-------------',nowtime];
    dlmwrite('bestpoints.txt', output_notice,'-append','delimiter', '','newline', 'pc');
    
elseif strcmp(x,'S_g')
    output_notice=['-------------Rand S_g-------------',nowtime];
    dlmwrite('bestpoints.txt', output_notice,'-append','delimiter', '','newline', 'pc');
    
elseif strcmp(x,'S_mw')
    output_notice=['-------------Rand S_mw-------------',nowtime];
    dlmwrite('bestpoints.txt', output_notice,'-append','delimiter', '','newline', 'pc');
    
elseif strcmp(x,'K_m')
    output_notice=['-------------Rand K_m-------------',nowtime];
    dlmwrite('bestpoints.txt', output_notice,'-append','delimiter', '','newline', 'pc');
    
else
    outdata = [S_w,S_g,S_mw,K_m,x];
    dlmwrite('bestpoints.txt', outdata,'-append', 'delimiter', '\t','precision', 6,'newline', 'pc');
    f = 1;
end
end