function res = canBePutInDroneCargoBay(DroneCargoBaytype,MED1,MED2,MED3)

MED = [MED1,MED2,MED3];
number_of_MED=nnz(MED);
if number_of_MED == 0
    % 这种是空异常。
    res = 0;
    warning('MED的数量不能为 0 !\n');
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
    % 未找到合适的类型。
    res = 0;
    warning('未知的DroneCargoBay类型：%d\n',DroneCargoBaytype);
end

end

