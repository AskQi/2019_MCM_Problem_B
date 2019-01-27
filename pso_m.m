clc;
clear all;
close all force;
global flag_success_arrived flag_moutain_unreachable flag_rod flag_rod_arrived flag_port flag_blank flag_iso
global bw_rod bw_obstacle bw_port bw_help bw_arrived_rod
global jingwei2px_bili_weight jingwei2px_bili_height jingwei2px_bili
global jingwei2km_bili km2px_bili drug_size drug_number_in_port airplane_radio_px
global f_max
f_max=10;
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
%B-G
airplane_radio_km=[
    26.33333333
    9
    7.5
    15.8
    8.533333333];
airplane_radio_px=(km2px_bili*airplane_radio_km)';
% �Ƿ����ͼ��
showpic = false;
% �Ƿ����PSO
makepso = true;
root_dir ='E:\Important\MatLab\2019_MCM_Problem_B' ;
rod_imgdir =[root_dir,'\imgs\'];
rod_imgname ='rod.jpg';
obstacle_imgdir =rod_imgdir;
obstacle_imgname ='obstacle.png';
%�߽羭γ�������������ң������ϣ���������
jingwei_boundary=[
    18,29,20
    17,58,27
    67,10,26
    65,38,56];
%��������ͼ��
px_resize=[500,1334];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ��ȡ��·��Ϣ
[bw_rod,bw_left,bw_right,bw_top,bw_bottom]=start_rod(rod_imgdir,rod_imgname,px_resize);
[bw_height,bw_weight]= getUseableSize(bw_left,bw_right,bw_top,bw_bottom);
fprintf('��·ͼƬ��Ч�ֱ��ʳߴ磺%dx%d,������%d\n',bw_height,bw_weight,bw_height/bw_weight);
fprintf('��·��ͼ���꣺\nleft��%d, right:%d, top:%d, bottom:%d\n-------------------\n\n',bw_left,bw_right,bw_top,bw_bottom);

% ��ȡ�ϰ���Ϣ
[bw_obstacle,bw_left,bw_right,bw_top,bw_bottom]=start_obstacle(obstacle_imgdir,obstacle_imgname,px_resize);
[bw_height,bw_weight]= getUseableSize(bw_left,bw_right,bw_top,bw_bottom);
fprintf('�ϰ�ͼƬ��Ч�ֱ��ʳߴ磺%dx%d,������%d\n',bw_height,bw_weight,bw_height/bw_weight);
fprintf('�ϰ���ͼ���꣺\nleft��%d, right:%d, top:%d, bottom:%d\n-------------------\n\n',bw_left,bw_right,bw_top,bw_bottom);

jingwei_boundary_top=...
    getMinute(jingwei_boundary(1,:));
jingwei_boundary_bottom=...
    getMinute(jingwei_boundary(2,:));
jingwei_boundary_left=...
    getMinute(jingwei_boundary(3,:)*(-1));
jingwei_boundary_right=...
    getMinute(jingwei_boundary(4,:)*(-1));
% ���ڵ��������εģ����Դ�ֱ��ˮƽ�ı����߲�һ����Ӧ�÷ֿ�����
jingwei2px_bili_weight=bw_weight/(jingwei_boundary_right-jingwei_boundary_left);
jingwei2px_bili_height=bw_height/(jingwei_boundary_top-jingwei_boundary_bottom);
jingwei2px_bili = (jingwei2px_bili_weight+jingwei2px_bili_height);
% ����������
[port_px]=start_port(bw_left,bw_bottom,jingwei_boundary_left,jingwei_boundary_bottom,jingwei2px_bili_height,jingwei2px_bili_weight);
port_px=int32(port_px);
bw_port = zeros(px_resize);
for x=1:size(port_px,1)
    bw_port(port_px(x,2),port_px(x,1))=flag_port;
end


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
%���Ӹ���
problem.nvars = 36 ;

resize_pop = 0.5+rand(1);
resize_generate = 0.5+rand(1);
generat = int32(problem.options.Generations*resize_generate)
pop = int32(problem.options.PopulationSize*resize_pop)
problem.options.Generations = generat;
problem.options.PopulationSize = pop;
% [xOpt,fval,exitflag,output,population,scores] = pso(problem)
try
    [xOpt,fval,exitflag,output,population,scores] = pso(problem);
    xOpt
    fval
catch ErrorInfo %���񵽵Ĵ�����һ��MException����
    disp(ErrorInfo);
    disp(ErrorInfo.identifier);
    disp(ErrorInfo.message);
    disp(ErrorInfo.stack);
    disp(ErrorInfo.cause);
    %��������ʱ����������
    % ������ǰ����
    clc;
    clear all;
    close all force;
    pso_m
    
end
%     %���Ӷ���
%     osi_1_x=x(1);
%     osi_1_y=x(2);
%     osi_2_x=x(3);
%     osi_2_y=x(4);
%     osi_3_x=x(5);
%     osi_3_y=x(6);
%     osi_1_airplane_number_send = x(7:11);
%     osi_1_airplane_number_scan = x(12:16);
%     osi_2_airplane_number_send = x(17:21);
%     osi_2_airplane_number_scan = x(22:26);
%     osi_3_airplane_number_send = x(27:31);
%     osi_3_airplane_number_scan = x(32:36);
%
