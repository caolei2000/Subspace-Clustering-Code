function [idx, Z, E] = LRR(X, lambda, k)
%LRR 使用LRR(low rank representation进行子空间聚类)
% Input:
%       X: 数据, size(X)=d*n;
%       lambda: 算法正则化参数;
%       k: 聚类簇数;
% Output:
%       idx: 聚类结果索引;
%       Z: 得到的表示矩阵;
%       E: 恢复时得到的误差矩阵;

[Z, E] = solve_lrr(X, lambda);  % 调用solve_lrr()
A = GetAmbyLRR(Z);  % 获得邻接矩阵
idx = SpectralClustering(A, k);  % 谱聚类

end

