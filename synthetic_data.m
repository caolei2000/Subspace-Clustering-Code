%% �ṩһ�ֺϳ����ݵķ���
% ��ʼ��
clear;
addpath(genpath(pwd));

dOrigin = 4;  % ԭʼ�ӿռ�ά��
dAmbient = 5;  % �����ӿռ�ά��(��ʵ�ʲ�������ά��)
nSubspace = 2;  % �ӿռ���Ŀ
nPoint = 100;  % ÿ���ӿռ����������Ŀ
isAddNoise = true;  % �Ƿ���Ӹ�˹����
%% ��������
fea = [];gnd = [];
for i = 1 : nSubspace
    basis = orth(randn(dAmbient, dOrigin));  % ����һ��ӳ�����, ��ͬ�ӿռ佫���в�ͬ��ӳ��
    fea = [fea, basis*rand(dOrigin, nPoint)];  % ԭʼ����ͨ��ӳ��, �õ�ʵ�ʲ�������
    gnd = [gnd; i*ones(nPoint, 1)];  % ��¼label
end
% ��Ӹ�˹����
if (isAddNoise)
    fea = fea + 0.1*randn(size(fea)); 
end
%% ����---ʹ��RANSAC
threshold = 0.01;
idxRANSAC = RANSAC(fea, dOrigin, nSubspace, threshold);
[MetricsRANSAC.ca, MetricsRANSAC.nmi, ~, ~, ~, ~] = ComputeMetrics(gnd, idxRANSAC);
MetricsRANSAC