function [CA, NMI, AR, F, P, R] = spectralClustering(A,k,truth)
%spectralClustering:输入相似矩阵（亲和力矩阵），进行谱聚类.
%一次谱聚类, 里面默认进行了10次kmeans, 每次计算指标, 最后取均值, 返回指标.
%Input:
%       A:相似矩阵，size(A)=n*n
%       k:聚类簇数
%Output:
%       CA:聚类准确度
%       NMI: 归一化互信息
%       AR: 调整兰德指数
%       F: F1
%       P: precision
%       R: recall

N = size(A,1); % 样本数

DN = diag( 1./sqrt(sum(A)+eps) );  % 度矩阵
LapN = speye(N) - DN * A * DN;  % 对称归一化
[~,~,vN] = svd(LapN);
kerN = vN(:,N-k+1:N);  % 选最小的k个特征值对应的特征向量
normN = sum(kerN .^2, 2) .^.5;
kerNS = bsxfun(@rdivide, kerN, normN + eps);  % 对其按行标准化
 
[CA, NMI, AR, F, P, R] = performKmeans(kerNS,k,truth);  % 执行kmeans, 返回指标

