function [group, b]=RANSAC(x, d, n, t)
%function [group,b]=ransac_subspaces(x,d,n,t)
%
%   Use RANSAC to iteratively and robustly find subspaces
% Input:
%       x   data points (K by N matrix)  (输入数据, size(x)=d*n)
%       d   dimension of the subspaces to find  (要找到的子空间的维度)
%       n   number of subspaces  (聚类簇数)
%       t   threshold for RANSAC  (判定为内点的阈值)
% Output:
%       group: 最终聚类索引;
%       b: 暂时不懂什么意思, 先不管;

DEBUG=0;
RESEGMENT=1;


if(DEBUG==1)
    legendstrings=[repmat('Group ',n,1) num2str([1:n]')];
end

[K,N]=size(x);

b=zeros(K,d,0);
outliers=1:N;
group=(n+1)*ones(1,N);
for(i=1:n)
    if(length(outliers)<4)
        for(j=1:i-1)
            Pi=eye(K)-b(:,:,j)*b(:,:,j)';
            dist(:,j)=sum((Pi*x).^2);
        end
        mindist=min(dist,2);
        [void, order]=sort(mindist);
        outliers=order(1:4);
    end
    [bsub,ins]=ransacfitarbitraryplane(x(:,outliers),d,t);
    b(:,:,i)=bsub;
    group(outliers(ins))=i;
    if(DEBUG==1)
        plotgroups2(x(:,outliers),group(outliers));legend(char(legendstrings(i,:),'Outliers'), 'Location', 'North');pause;
    end
    outliers=setdiff(outliers,outliers(ins));
end

%plotgroups2(x,group);pause;

if(RESEGMENT==1)
    b=zeros(size(x,1),n,d);
    for(i=1:n)
        [U,S,V]=svd(x(:,find(group==i)),'econ');
        b(:,i,:)=U(:,1:d);
    end

    for(j=1:size(b,2))
        P=squeeze(b(:,j,:));
        P=eye(K)-P*P';
        distance(j,:)=sum((P*x).^2);
    end
    [val,group] = min(distance,[],1); 
end

if(DEBUG==1)
    plotgroups2(x,group);legend(legendstrings, 'Location', 'North');
end
group = group';

end
