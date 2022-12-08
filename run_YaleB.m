%% ���� Extended Yale B ���ݼ�(ExtYaleB_1024.mat, 1024ά����)
% ������ݼ����, ���ڵ�Ԥ��������Ϊ:
% 1. ���ص��һ����[0, 1]
% 2. ʹ��PCA��ά, ����98%��Ϣ��
clear;
addpath(genpath(pwd));
load ExtYaleB_1024.mat;
gnd = gnd';
% feaΪ���ݣ�size(fea)=d*n
% gndΪlabel, size(label)=n*1
%% ѡ��subjects����(�������)
nCluster = 4;  % �������
num = nCluster * 64;  % �ܵ�������(ÿ������64������)
fea = fea(:, 1:num);
gnd = gnd(1:num, :);
%% Ԥ����1---���ݹ�һ����[0,1]��minMax��һ��
fea = fea / 255;
%% Ԥ����2---PCA ��ά, ����98%��Ϣ��
[coeff, score, latent] = pca(fea');
idx = find(cumsum(latent)/sum(latent) > 0.98);
p = idx(1);
fea = score(:, 1:p)';
%% k-means
disp('Clustering by k-means');
idxKmeans = kmeans(fea', nCluster);  % kmeans�����������ʽ��n*d, ����ת��һ��.
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
d = 5;  % Ҫ�ҵ����ӿռ��ά��
threshold = 0.01;  % �㷨����, һ����ֵ
idxRANSAC = RANSAC(fea, d, nCluster, threshold);
[MetricsRANSAC.ca, MetricsRANSAC.nmi, ~, ~, ~, ~] = ComputeMetrics(gnd, idxRANSAC);
MetricsRANSAC
%% SSC
disp('Clustering by SSC');
r = 0; affine = false; alpha= 90000; outlier = true; rho = 1;
[idxSSC, CMat]= SSC(fea, r, affine, alpha, outlier, rho, nCluster);
[MetricsSSC.ca, MetricsSSC.nmi, ~, ~, ~, ~] = ComputeMetrics(gnd, idxSSC);
MetricsSSC