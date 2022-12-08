%% 提供一种合成数据的方法
% 初始化
clear;
addpath(genpath(pwd));

kOrigin = 4;  % 原始子空间维度
kAmbient = 5;  % 环境子空间维度(即实际采样到的维度)
nSubspace = 2;  % 子空间数目
nPoint = 100;  % 每个子空间的样本点数目
isAddNoise = true;  % 是否添加高斯噪声
%% 生成数据
fea = [];gnd = [];
for i = 1 : nSubspace
    basis = orth(randn(kAmbient, kOrigin));  % 生成一个映射矩阵, 不同子空间将会有不同的映射
    fea = [fea, basis*rand(kOrigin, nPoint)];  % 原始数据通过映射, 得到实际采样数据
    gnd = [gnd; i*ones(nPoint, 1)];  % 记录label
end
% 添加高斯噪声
if (isAddNoise)
    fea = fea + 0.1*randn(size(fea)); 
end
%% 测试---使用RANSAC
threshold = 0.01;
idxRANSAC = RANSAC(fea, kOrigin, nSubspace, threshold);
[MetricsRANSAC.ca, MetricsRANSAC.nmi, ~, ~, ~, ~] = ComputeMetrics(gnd, idxRANSAC);
MetricsRANSAC