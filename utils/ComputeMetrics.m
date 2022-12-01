function [ca, nmi, ar, f1, p, r] = ComputeMetrics(gnd, idx)
%COMPUTEMETRICS 
% �����������յĴ������Լ�ground truth����ָ��
% Input:
%       gnd: ground truth, size(gnd)=n*1;
%       idx: �㷨�õ�������������, size(idx)=n*1;
% Output:
%       ca: ���ྫ��;
%       nmi: ��һ������Ϣ;
%       ar: ��������ָ��;
%       f1: F1 score;
%       p: precision;
%       r: recall;

warning('off');
if (min(gnd)==0)
    gnd = gnd+1;
end

% �������ָ��, ��������ĺ���ûȥ�
ca = 1 - compute_CE(idx, gnd);
nmi = compute_nmi(gnd,idx);
ar = rand_index(gnd,idx);
[f1, p, r] = compute_f(gnd,idx);

end
