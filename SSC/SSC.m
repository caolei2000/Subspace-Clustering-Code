%--------------------------------------------------------------------------
% This is the function to call the sparse optimization program, to call the 
% spectral clustering algorithm and to compute the clustering error.
% r = projection dimension, if r = 0, then no projection
% affine = use the affine constraint if true
% s = clustering ground-truth
% missrate = clustering error
% CMat = coefficient matrix obtained by SSC
%--------------------------------------------------------------------------
% Copyright @ Ehsan Elhamifar, 2012
%--------------------------------------------------------------------------

function [idx,CMat] = SSC(X, r, affine, alpha, outlier, rho, k)
% Input: 
%       X: 数据, size(X)=n*d;
%       r: 使用PCA进行映射降维后的维度, 若r=0, 则不降维(通常取0);
%       affine: bool, 是否进行仿射变换(意义暂时未懂);
%       alpha: 算法正则化参数;
%       outlier: bool, 是否添加离群项约束(对结果有较大影响);
%       rho: 构建邻接矩阵时的一个参数, 意义暂时未懂(对结果影响不大);
%       k: 聚类簇数(子空间数目);
% Output:
%       idx: 聚类结果索引, size(idx)=n*1;
%       CMat: SSC得到的稀疏系数矩阵, size(CMat)=n*n;

if (nargin < 6)
    rho = 1;
end
if (nargin < 5)
    outlier = false;
end
if (nargin < 4)
    alpha = 20;
end
if (nargin < 3)
    affine = false;
end
if (nargin < 2)
    r = 0;
end

Xp = DataProjection(X,r);  % 投影降维

% 根据是否有outlier采用不同的求解方法, 里面有输出信息, 被我注释掉了
if (~outlier)
    CMat = admmLasso_mat_func(Xp,affine,alpha);
    C = CMat;
else
    CMat = admmOutlier_mat_func(Xp,affine,alpha);
    N = size(Xp,2);
    C = CMat(1:N,:);
end

CKSym = BuildAdjacency(thrC(C,rho));  % 这相当于SSC自己的由表示矩阵得到邻接矩阵的方法
idx = SpectralClustering(CKSym, k);
