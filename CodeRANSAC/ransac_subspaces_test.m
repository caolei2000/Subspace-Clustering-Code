%Function to test routine for RANSAC
randn('state',2)
rand('state',1)

k=4;    %dimension of subspaces
K=5;    %dimension of ambient space
N=100;  %number of points in each group
n=2;    %number of groups
thresh=0.01;    %threshold for inliers
addnoise=false; %add random gaussian noise?

%prepare dataset
X=[];s=[];
for(in=1:n)
    basis=orth(randn(K,k));
    X=[X basis*rand(k,N)];
    s=[s in*ones(1,N)];
end

%add noise if asked for
if(addnoise)
    X=X+0.01*randn(size(X));
end

Ntruth=N*ones(1,n); %ground truth

%call RANSAC for subspace segmentation
[groups, b]=ransac_subspaces(X,k,n,0.01);

%compute misclassification rate
groups=bestMap(s,groups);
missrate = sum(s(:) ~= groups(:)) / length(s);

disp(['Missclassification error: ' num2str(missrate*100) '%'])
