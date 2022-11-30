% Run k-means n times and report means and standard deviations of the
% performance measures.
%
% -------------------------------------------------------
% Input:
%       X:  data matrix (rows are samples)
%       k:  number of clusters
%       truth:  truth cluster indicators
%     
%
% Output:
%       CA:  clustering accuracy (mean +stdev)
%       F:  F1 measure (mean +stdev)
%       P:  precision (mean +stdev)
%       R:  recall (mean +stdev)
%       nmi:  normalized mutual information (mean +stdev)
%       AR:  adjusted rand index (mean +stdev)
%
function [CA, NMI, AR, F, P, R] = performKmeans(X, k, truth)
max_iter = 1000; % Maximum number of iterations for KMeans
replic = 10; % 默认每次谱聚类里面执行的kmeans次数

if (min(truth)==0)
    truth = truth+1;
end

warning('off');

% 重复replic次数，然后求各类指标的均值和方差
for i=1:replic
    idx = kmeans(X, k,'EmptyAction','singleton','maxiter',max_iter);
    CAi(i) = 1-compute_CE(idx, truth); % clustering accuracy
    NMII(i) = compute_nmi(truth,idx);
    ARi(i) = rand_index(truth,idx);
    [Fi(i),Pi(i),Ri(i)] = compute_f(truth,idx); % F1, precision, recall
end
CA = mean(CAi);
NMI = mean(NMII);
AR = mean(ARi);
F = mean(Fi);
P = mean(Pi);
R = mean(Ri);

end
