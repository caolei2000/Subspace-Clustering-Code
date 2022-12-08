function [idx, Z, E] = LRR(X, lambda, k)
%LRR ʹ��LRR(low rank representation�����ӿռ����)
% Input:
%       X: ����, size(X)=d*n;
%       lambda: �㷨���򻯲���;
%       k: �������;
% Output:
%       idx: ����������;
%       Z: �õ��ı�ʾ����;
%       E: �ָ�ʱ�õ���������;

[Z, E] = solve_lrr(X, lambda);  % ����solve_lrr()
A = GetAmbyLRR(Z);  % ����ڽӾ���
idx = SpectralClustering(A, k);  % �׾���

end

