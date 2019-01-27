clc;
clear all;
global flag_success_arrived flag_moutain_unreachable flag_rod flag_rod_arrived flag_port flag_blank flag_iso
global bw_rod bw_obstacle bw_port bw_help bw_arrived_rod
global jingwei2px_bili_weight jingwei2px_bili_height jingwei2px_bili
global jingwei2km_bili km2px_bili drug_size drug_number_in_port
jingwei2km_bili=11/6;
km2px_bili=15.5*6/11;
flag_moutain_unreachable = -1;
flag_blank = 0;
flag_rod = 1;
flag_success_arrived = 2;
flag_rod_arrived = 3;
flag_port = 4;
flag_iso = 5;
drug_size = [
    14 7 5
    5 8 5
    12 7 4];
drug_number_in_port = [
    1 0 1
    2 0 1
    1 1 0
    2 1 2
    1 0 0];
% 是否绘制图形
showpic = false;
% 是否进行PSO
makepso = true;
root_dir ='E:\Important\MatLab\2019' ;
rod_imgdir =[root_dir,'\imgs\'];
rod_imgname ='rod.jpg';
obstacle_imgdir =rod_imgdir;
obstacle_imgname ='obstacle.png';
%边界经纬条件：上下左右（北，南，西，东）
jingwei_boundary=[
    18,29,20
    17,58,27
    67,10,26
    65,38,56];
%重新缩放图形
px_resize=[500,1334];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 获取公路信息
[bw_rod,bw_left,bw_right,bw_top,bw_bottom]=start_rod(rod_imgdir,rod_imgname,px_resize);
[bw_height,bw_weight]= getUseableSize(bw_left,bw_right,bw_top,bw_bottom);
fprintf('公路图片有效分辨率尺寸：%dx%d,比例：%d\n',bw_height,bw_weight,bw_height/bw_weight);
fprintf('公路绘图坐标：\nleft：%d, right:%d, top:%d, bottom:%d\n-------------------\n\n',bw_left,bw_right,bw_top,bw_bottom);

% 获取障碍信息
[bw_obstacle,bw_left,bw_right,bw_top,bw_bottom]=start_obstacle(obstacle_imgdir,obstacle_imgname,px_resize);
[bw_height,bw_weight]= getUseableSize(bw_left,bw_right,bw_top,bw_bottom);
fprintf('障碍图片有效分辨率尺寸：%dx%d,比例：%d\n',bw_height,bw_weight,bw_height/bw_weight);
fprintf('障碍绘图坐标：\nleft：%d, right:%d, top:%d, bottom:%d\n-------------------\n\n',bw_left,bw_right,bw_top,bw_bottom);

jingwei_boundary_top=...
    getMinute(jingwei_boundary(1,:));
jingwei_boundary_bottom=...
    getMinute(jingwei_boundary(2,:));
jingwei_boundary_left=...
    getMinute(jingwei_boundary(3,:)*(-1));
jingwei_boundary_right=...
    getMinute(jingwei_boundary(4,:)*(-1));
% 由于地球是球形的，所以垂直和水平的比例尺不一样，应该分开处理。
jingwei2px_bili_weight=bw_weight/(jingwei_boundary_right-jingwei_boundary_left);
jingwei2px_bili_height=bw_height/(jingwei_boundary_top-jingwei_boundary_bottom);
jingwei2px_bili = (jingwei2px_bili_weight+jingwei2px_bili_height);
% 五个点的坐标
[port_px]=start_port(bw_left,bw_bottom,jingwei_boundary_left,jingwei_boundary_bottom,jingwei2px_bili_height,jingwei2px_bili_weight);
port_px=int32(port_px);
bw_port = zeros(px_resize);
for x=1:size(port_px,1)
    bw_port(port_px(x,2),port_px(x,1))=flag_port;
end




%是否执行PSO
if ~makepso
    
else
    workingdir = pwd ;
    testdir = dir('mfcn*') ;
    cd(testdir.name);
    % [testfcn,testdir] = uigetfile('*.m','Load demo function for PSO') ;
    testfcn='fcn_2019.m';
    testdir=[root_dir,'\mfcns\'];
    if ~testfcn
        cd(workingdir);
        return
    elseif isempty(regexp(testfcn,'\.m(?!.)','once'))
        error('The function file must be m-file')
    else
        cd(testdir)
    end
    
    fitnessfcn = str2func(testfcn(1:regexp(testfcn,'\.m(?!.)')-1)) ;
    cd(workingdir)
    
    options = fitnessfcn('init') ;
    
    if any(isfield(options,{'options','Aineq','Aeq','LB','nonlcon'}))
        % Then the test function gave us a (partial) problem structure.
        problem = options ;
    else
        % Aineq = [1 1] ; bineq = [1.2] ; % Test case for linear constraint
        problem.options = options ;
        problem.Aineq = [] ; problem.bineq = [] ;
        problem.Aeq = [] ; problem.beq = [] ;
        problem.LB = [] ; problem.UB = [] ;
        problem.nonlcon = [] ;
    end
    
    problem.fitnessfcn = fitnessfcn ;
    %粒子个数
    problem.nvars = 6 ;
    [xOpt,fval,exitflag,output,population,scores] = pso(problem)
    
    %粒子定义
    osi_1_x=x(1);
    osi_1_y=x(2);
    osi_2_x=x(3);
    osi_2_y=x(4);
    osi_3_x=x(5);
    osi_3_y=x(6);
    osi_1_airplane_number_send = x(7:9);
    osi_1_airplane_number_scan = x(7:9);
    
    
    % S_w_def=1.064;
    % S_g_def=1.976;
    % S_mw_def=2;
    % K_m_def=32.5;
    % S_w=1.064;
    % S_g=1.976;
    % S_mw=2;
    % K_m=32.5;
    %
    % output2file('begin');
    % output2file('K_m');
    % point_nomber = 100;
    % for i=1:point_nomber
    %     %变化范围为原来的90%~110%
    %     discount=1+(rand(1)*0.2-0.1);
    %     K_m=K_m_def*discount;
    %     fprintf('当前正在进行第 %d/%d 个任务',i,point_nomber);
    %     pso(problem)
    % end
    % output2file('end');
    
    
end

if ~showpic
    
else
    
    % 绘制图形
    % imshow(bw);
    % hold on;
    figure
    grid on; %显示网格线
    axis on; %显示坐标系
    hold on;
    for x=bw_left:bw_right
        for y=bw_bottom:bw_top
            if(bw_rod(y,x)==flag_rod)
                %这里是公路
                plot(x,y,'g.');
            elseif (bw_obstacle(y,x)==flag_moutain_unreachable)
                %这里是障碍
                plot(x,y,'r.');
            elseif(bw_help(y,x)==flag_success_arrived)
                %这里是公路
                plot(x,y,'c.');
            elseif(bw_help(y,x)==flag_iso)
                %这里是ISO
                plot(x,y,'ko');
            elseif(bw_arrived_rod(y,x)==flag_rod_arrived)
                %这里是被拍到的公路
                plot(x,y,'b.');
            elseif(bw_port(y,x)==flag_port)
                %这里是五点坐标
                plot(x,y,'-k*');
            end
        end
    end
    % 绘制左右边框
    x=ones(numel(bw_bottom-bw_top))*bw_left;
    y=bw_bottom:bw_top;
    plot(x,y,'-r.');
    x=ones(numel(bw_bottom-bw_top))*bw_right;
    plot(x,y,'-r.');
    % 绘制上下边框
    x=bw_left:bw_right;
    y=bw_top;
    plot(x,y,'-r.');
    y=bw_bottom;
    plot(x,y,'-r.');
end