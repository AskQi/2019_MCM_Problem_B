function res = canBePutInDroneCargoBay(DroneCargoBaytype,MED1,MED2,MED3)

MED = [MED1,MED2,MED3];
number_of_MED=nnz(MED);
if number_of_MED == 0
    % �����ǿ��쳣��
    res = 0;
    warning('MED����������Ϊ 0 !\n');
    return;
end

DroneCargoBaytype_1=1;
DroneCargoBaytype_2=2;
DroneCargoBaytype_1_allowed_MED = [...
    1 0 0
    0 1 0
    0 0 1
    0 2 0
    0 0 2];
DroneCargoBaytype_2_allowed_MED = [
    1 0 0
    0 1 0
    0 0 1
    1 1 0
    1 0 1
    0 1 1
    2 0 0
    0 2 0
    0 0 2
    2 0 1
    2 1 0
    0 3 0];
if DroneCargoBaytype == DroneCargoBaytype_1
    res = ismember(MED,DroneCargoBaytype_1_allowed_MED,'rows');
elseif DroneCargoBaytype == DroneCargoBaytype_2
    res = ismember(MED,DroneCargoBaytype_2_allowed_MED,'rows');
else
    % δ�ҵ����ʵ����͡�
    res = 0;
    warning('δ֪��DroneCargoBay���ͣ�%d\n',DroneCargoBaytype);
end

end

