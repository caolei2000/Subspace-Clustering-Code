%% 运行 Extended Yale B 数据集(ExtYaleB_1024.mat, 1024维数据)
% 这个数据集最常用, 现在的预处理流程为:
% 1. 像素点归一化到[0, 1]
% 2. 使用PCA降维, 保留98%信息量
clear;
addpath(genpath(pwd));
load ExtYaleB_1024.mat;
gnd = gnd';
% fea为数据，size(fea)=d*n
% gnd为label, size(label)=n*1
%% 选择subjects数量(聚类簇数)
nCluster = 4;  % 聚类簇数
num = nCluster * 64;  % 总的数据量(每个簇有64个数据)
fea = fea(:, 1:num);
gnd = gnd(1:num, :);
%% 预处理1---数据归一化到[0,1]，minMax归一化
fea = fea / 255;
%% 预处理2---PCA 降维, 保留98%信息量
[coeff, score, latent] = pca(fea');
idx = find(cumsum(latent)/sum(latent) > 0.98);
p = idx(1);
fea = score(:, 1:p)';
%% k-means
disp('Clustering by k-means');
idxKmeans = kmeans(fea', nCluster);  % kmeans的数据输入格式是n*d, 所以转置一下.
[MetricsKmeans.ca, MetricsKmeans.nmi, ~, ~, ~, ~] = ComputeMetrics(gnd, idxKmeans);
MetricsKmeans
%% GPCA
disp('Clustering by GPCA');
method = 'Cos';
idxGPCA = GPCA(fea, nCluster, method);
[MetricsGPCA.ca, MetricsGPCA.nmi, ~, ~, ~, ~] = ComputeMetrics(gnd, idxGPCA);
MetricsGPCA
%% RANSAC
disp('Clustering by RANSAC');
d = 5;  % 要找到的子空间的维度
threshold = 0.01;  % 算法参数, 一个阈值
idxRANSAC = RANSAC(fea, d, nCluster, threshold);
[MetricsRANSAC.ca, MetricsRANSAC.nmi, ~, ~, ~, ~] = ComputeMetrics(gnd, idxRANSAC);
MetricsRANSAC
%% SSC
disp('Clustering by SSC');
r = 0; affine = false; alpha= 90000; outlier = true; rho = 1;
[idxSSC, CMat]= SSC(fea, r, affine, alpha, outlier, rho, nCluster);
[MetricsSSC.ca, MetricsSSC.nmi, ~, ~, ~, ~] = ComputeMetrics(gnd, idxSSC);
MetricsSSC