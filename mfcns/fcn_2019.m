function f = fcn_2019(x)
global flag_success_arrived flag_moutain_unreachable flag_rod flag_rod_arrived flag_port flag_blank
global bw_rod bw_obstacle bw_port port_location_px f_max
global jingwei2px_bili_weight jingwei2px_bili_height jingwei2px_bili
global jingwei2km_bili km2px_bili drug_size drug_number_needs_in_port_daily airplane_radio_px
%function x(1)=heateqal(x(1),x(2),x(3),x(4),x(5),x(6),x(7),x(8))
% Template for writing custom test/demonstration functions for psodemo.
% Change the function name and save as a different file to preserve this
% template for future use.
%
% NOTE: defining KnownMin is only for the purposes of demonstration
% plotting. It does not help the particle swarm algorithm in any way.

if strcmp(x,'init')
    %     f.Aineq = diag(ones(1,6))*-1 ;%线性不等式约束的矩阵
    %     f.bineq = [1;1;1;1;1;1]*-1 ;%线性不等式约束的向量
    f.Aineq = [] ;%线性不等式约束的矩阵
    f.bineq = [] ;%线性不等式约束的向量
    f.Aeq = [] ;%用于线性等式约束的矩阵
    f.beq = [] ;%用于线性等式约束的向量
    %     osi_1_x osi_1_y osi_2_x osi_2_y osi_3_x osi_3_y
    iso_position_LB=[200 200 400 150 800  200];
    iso_position_UB=[800 400 900 500 1300 500];
%         iso_position_LB=[1    1    1    1    1    1];
%         iso_position_UB=[1334 1334 1334 1334 1334 1334];
    %     osi_1_send osi_1_scan osi_2_send osi_2_scan osi_3_send osi_3_scan
    osi_1_send_LB=[0 0 0 0 0];
    osi_1_send_UB=[1 1 1 1 1];
    osi_1_scan_LB=[0 0 0 0 0];
    osi_1_scan_UB=[0 1 1 1 1];
    osi_2_send_LB=[0 0 0 0 0];
    osi_2_send_UB=[1 1 1 1 1];
    osi_2_scan_LB=[0 0 0 0 0];
    osi_2_scan_UB=[0 1 1 1 1];
    osi_3_send_LB=[0 0 0 0 0];
    osi_3_send_UB=[1 1 1 1 1];
    osi_3_scan_LB=[0 0 0 0 0];
    osi_3_scan_UB=[0 9 9 9 9];
    osi_airplane_number_send_LB = [osi_1_send_LB,osi_1_scan_LB,osi_2_send_LB,osi_2_scan_LB,osi_3_send_LB,osi_3_scan_LB];
    osi_airplane_number_send_UB = [osi_1_send_UB,osi_1_scan_UB,osi_2_send_UB,osi_2_scan_UB,osi_3_send_UB,osi_3_scan_UB];
    
    f.LB = [iso_position_LB,osi_airplane_number_send_LB] ;%变量的下边界
    f.UB = [iso_position_UB,osi_airplane_number_send_UB] ;%变量的上边界
    %     f.LB = [1    1    1    1    1    1] ;%变量的下边界
    %     f.UB = [1334 500  1334 500  1334 500] ;%变量的上边界
    %     f.nonlcon = [] ; % Could also use 'heart' or 'unitdisk'
    f.options=[];
    %     代数
    f.options.Generations = 5;
    f.nonlcon = 'limit2019';
    
%     f.options.ConstrBoundary = 'penalize';
    f.options.PopulationSize = 200;
    f.options.UseParallel = 'never';
else
    x=int32(x);
    if min(x)<0
        f =f_max
        return;
    end
    osi_1_x=x(1);
    osi_1_y=x(2);
    osi_2_x=x(3);
    osi_2_y=x(4);
    osi_3_x=x(5);
    osi_3_y=x(6);
%     osi_1_airplane_number_send = int32(x(7:11));
osi_1_airplane_number_send = [];
    osi_1_airplane_number_scan = int32(x(12:16));
    osi_2_airplane_number_send = int32(x(17:21));
    osi_2_airplane_number_scan = int32(x(22:26));
    osi_3_airplane_number_send = int32(x(27:31));
    osi_3_airplane_number_scan = int32(x(32:36));
    radio_osi_1_scan_km=26.3;
    %     radio_jingwei = radio_km/jingwei2km_bili;
    %     radio_px = radio_jingwei*jingwei2px_bili
    radio_osi_1_scan_px = km2px_bili*radio_osi_1_scan_km;
    
    
    [height,width]=size(bw_obstacle);
    % 侦查无人机能够到达的位置
    bw_help1 = helper(height,width,osi_1_x,osi_1_y,radio_osi_1_scan_px);
    bw_help2 = helper(height,width,osi_2_x,osi_2_y,radio_osi_1_scan_px);
    bw_help3 = helper(height,width,osi_3_x,osi_3_y,radio_osi_1_scan_px);
    bw_help=bw_help1|bw_help2|bw_help3;
    arrived_port_number = nnz(bw_port&bw_help);
    limit_can_arrive_port = arrived_port_number>=5;
    fprintf('到达Port: %d\n',arrived_port_number);
    
    
    if limit_can_arrive_port
        % 该路径可以观察到的道路点数
        bw_arrived_rod=bw_rod&bw_help*flag_rod_arrived;
        numebr_of_rod_points = nnz(bw_rod);
        numebr_of_arrived_rod_points = nnz(bw_arrived_rod);
        proportion_of_arrived_rod_points=numebr_of_arrived_rod_points/numebr_of_rod_points;
        fprintf('到达公路比例:\n %d / %d = %s\n',numebr_of_arrived_rod_points,numebr_of_rod_points,proportion_of_arrived_rod_points);
        
    else
        f=f_max
        return;
    end
    f=1/proportion_of_arrived_rod_points;
    f=abs(f);
    x
    f
    
end