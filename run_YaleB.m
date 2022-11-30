%% 运行 Extended Yale B 数据集(ExtYaleB_1024.mat, 1024维数据)
% 这个数据集最常用, 现在的预处理流程为:
% 1. 像素点归一化到[0, 1]
% 2. 使用PCA降维, 保留98%信息量
clear;
addpath(genpath(pwd));
load ExtYaleB_1024.mat;
% fea为数据，size(fea)=d*n
% gnd为label, size(label)=1*n(下一步处理会变成n*1(实际使用的))
%% 选择subjects数量
nCluster = 3;           % 聚类簇数
num = nCluster * 64;    % 总的数据量(每个簇有64个数据)
fea = fea(:,1:num);
gnd = gnd(:,1:num)';
%% 预处理1---数据归一化到[0,1]，minMax归一化
fea = fea / 255;
%% 预处理2---PCA 降维, 保留98%信息量
[coeff, score, latent] = pca(fea');
idx = find(cumsum(latent)/sum(latent) > 0.98);
p = idx(1);
fea = score(:, 1:p)';
%% 使用k-means算法
disp('Clustering by k-means');
[CA, NMI, AR, F, P, R] = performKmeans(fea', nCluster, gnd);
CA
NMI
AR
F
P
R
%% RANSAC