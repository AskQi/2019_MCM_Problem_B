function f = fcn_2019(x)
global flag_success_arrived flag_moutain_unreachable flag_rod flag_rod_arrived flag_port flag_blank
global bw_rod bw_obstacle bw_port port_location_px
global jingwei2px_bili_weight jingwei2px_bili_height jingwei2px_bili
global jingwei2km_bili km2px_bili drug_size drug_number_in_port
%function x(1)=heateqal(x(1),x(2),x(3),x(4),x(5),x(6),x(7),x(8))
% Template for writing custom test/demonstration functions for psodemo.
% Change the function name and save as a different file to preserve this
% template for future use.
%
% NOTE: defining KnownMin is only for the purposes of demonstration
% plotting. It does not help the particle swarm algorithm in any way.

if strcmp(x,'init')
    f.Aineq = diag(ones(1,6))*-1 ;%���Բ���ʽԼ���ľ���
    f.bineq = [1;1;1;1;1;1]*-1 ;%���Բ���ʽԼ��������
    f.Aeq = [] ;%�������Ե�ʽԼ���ľ���
    f.beq = [] ;%�������Ե�ʽԼ��������
    f.LB = [1   200 400  150 1000 200] ;%�������±߽�
    f.UB = [800 350 1200 500 1200 400] ;%�������ϱ߽�
    %     f.LB = [1    1    1    1    1    1] ;%�������±߽�
    %     f.UB = [1334 500  1334 500  1334 500] ;%�������ϱ߽�
    %     f.nonlcon = [] ; % Could also use 'heart' or 'unitdisk'
    f.options=[];
    %     ����
    f.options.Generations = 1;
    f.nonlcon = 'limit2019';
    
    f.options.ConstrBoundary = 'penalize';
    f.options.PopulationSize = 100;
    f.options.UseParallel = 'never';
else
    x=int32(x);
    if min(x)<=0
        proportion_of_arrived_rod_points = 0;
        f =1/proportion_of_arrived_rod_points;
        return;
    end
    radio_km=26.3;
    %     radio_jingwei = radio_km/jingwei2km_bili;
    %     radio_px = radio_jingwei*jingwei2px_bili
    radio_px = km2px_bili*radio_km;
    osi_1_x=x(1);
    osi_1_y=x(2);
    osi_2_x=x(3);
    osi_2_y=x(4);
    osi_3_x=x(5);
    osi_3_y=x(6);
    %     bw_help1=help1(bw_obstacle,osi_1_x,osi_1_y,radio_px);
    %     bw_help2=help1(bw_obstacle,osi_2_x,osi_2_y,radio_px);
    %     bw_help3=help1(bw_obstacle,osi_3_x,osi_3_y,radio_px);
    
    [height,width]=size(bw_obstacle);
    % ���˻��ܹ������λ��
    bw_help1 = helper(height,width,osi_1_x,osi_1_y,radio_px);
    bw_help2 = helper(height,width,osi_2_x,osi_2_y,radio_px);
    bw_help3 = helper(height,width,osi_3_x,osi_3_y,radio_px);
    bw_help=bw_help1|bw_help2|bw_help3;
    arrived_port_number = nnz(bw_port&bw_help);
    limit_can_arrive_port = arrived_port_number>=5;
    fprintf('����Port:\n %d\n',arrived_port_number);
    if limit_can_arrive_port
        % ��·�����Թ۲쵽�ĵ�·����
        bw_arrived_rod=bw_rod&bw_help*flag_rod_arrived;
        numebr_of_rod_points = nnz(bw_rod);
        numebr_of_arrived_rod_points = nnz(bw_arrived_rod);
        proportion_of_arrived_rod_points=numebr_of_arrived_rod_points/numebr_of_rod_points;
        fprintf('���﹫·����:\n %d / %d = %s\n',numebr_of_arrived_rod_points,numebr_of_rod_points,proportion_of_arrived_rod_points);
        
    else
        proportion_of_arrived_rod_points=0;
    end
    f=1/proportion_of_arrived_rod_points;
    f=double(f);
    disp(x);
    disp(f);
    
end