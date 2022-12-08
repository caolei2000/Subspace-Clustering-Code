function [idx, b]=RANSAC(x, d, n, t)
%function [idx,b]=RANSAC(x,d,n,t)
%
%   Use RANSAC to iteratively and robustly find subspaces
% Input:
%       x   data points (K by N matrix)  (��������, size(x)=d*n)
%       d   dimension of the subspaces to find  (Ҫ�ҵ����ӿռ��ά��)
%       n   number of subspaces  (�������\�ӿռ���Ŀ)
%       t   threshold for RANSAC  (�ж�Ϊ�ڵ����ֵ)
% Output:
%       idx: ����������, size(idx)=n*1;
%       b: ��ʱ����ʲô��˼, �Ȳ���;

DEBUG=0;
RESEGMENT=1;


if(DEBUG==1)
    legendstrings=[repmat('Group ',n,1) num2str([1:n]')];
end
[K,N]=size(x);

b=zeros(K,d,0);
outliers=1:N;
idx=(n+1)*ones(1,N);
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
    idx(outliers(ins))=i;
    if(DEBUG==1)
        plotgroups2(x(:,outliers),idx(outliers));legend(char(legendstrings(i,:),'Outliers'), 'Location', 'North');pause;
    end
    outliers=setdiff(outliers,outliers(ins));
end

%plotgroups2(x,group);pause;

if(RESEGMENT==1)
    b=zeros(size(x,1),n,d);
    for(i=1:n)
        [U,S,V]=svd(x(:,find(idx==i)),'econ');
        b(:,i,:)=U(:,1:d);
    end

    for(j=1:size(b,2))
        P=squeeze(b(:,j,:));
        P=eye(K)-P*P';
        distance(j,:)=sum((P*x).^2);
    end
    [val,idx] = min(distance,[],1); 
end

if(DEBUG==1)
    plotgroups2(x,idx);legend(legendstrings, 'Location', 'North');
end
idx = idx';

end
