function [left,right,top,bottom]= getBoundary(bw)
[M,N] = size(bw);
left=1;
right=N;
top=M;
bottom=1;
%获取左部不为空的位置
for x=1:N/2
    this_row=bw(:,x);
    max_this_row=max(this_row);
    min_this_row=min(this_row);
%     fprintf('x:%d max_this_line:%d min_this_line:%d\n',x,min_this_row,max_this_row);
    is_zero=(max_this_row==0 && min_this_row==0);
    if is_zero
        left=x;
    else
        break;
    end
end
%获取右部不为空的位置
for x=N:-1:N/2
    this_row=bw(:,x);
    max_this_row=max(this_row);
    min_this_row=min(this_row);
%     fprintf('x:%d max_this_line:%d min_this_line:%d\n',x,min_this_row,max_this_row);
    is_zero=(max_this_row==0 && min_this_row==0);
    if is_zero
        right=x;
    else
        break;
    end
end

%获取底部不为空的位置
for y=1:M/2
    this_line=bw(y,:);
    max_this_line=max(this_line);
    min_this_line=min(this_line);
%     fprintf('y:%d max_this_line:%d min_this_line:%d\n',y,min_this_line,max_this_line);
    is_zero=(max_this_line==0 && min_this_line==0);
    if is_zero
        bottom=y;
    else
        break;
    end
end
%获取顶部不为空的位置
for y=M:-1:M/2
    this_line=bw(y,:);
    max_this_line=max(this_line);
    min_this_line=min(this_line);
%     fprintf('y:%d max_this_line:%d min_this_line:%d\n',y,min_this_line,max_this_line);
    is_zero=(max_this_line==0 && min_this_line==0);
    if is_zero
        top=y;
    else
        break;
    end
end
end