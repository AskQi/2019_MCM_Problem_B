function pso_m()
% Runs the PSO on a few demonstration functions, which should be located
% in the <./testfcns> directory.
%
% For less intensive 3D graphics, run with input argument 'fast', viz.:
% >> pso_m('fast')
%
% S. Chen, Dec 2009.
% Available as part of "Another Particle Swarm Toolbox" at:
% http://www.mathworks.com/matlabcentral/fileexchange/25986
% Distributed under BSD license.

clc;
clear;
format long;
workingdir = pwd ;
testdir = dir('mfcn*') ;
if ~isempty(testdir.name), cd(testdir.name), end

[testfcn,testdir] = uigetfile('*.m','Load demo function for PSO') ;
% testfcn='notcomplete2.m';
% testdir='E:\Important\MatLab\psomatlab\mfcns\';
if ~testfcn
    cd(workingdir)
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
%Á£×Ó¸öÊý
problem.nvars = 3 ;
pso(problem)
end
