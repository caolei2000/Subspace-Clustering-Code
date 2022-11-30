function [CA, NMI, AR, F, P, R] = spectralClustering(A,k,truth)
%spectralClustering:�������ƾ����׺������󣩣������׾���.
%һ���׾���, ����Ĭ�Ͻ�����10��kmeans, ÿ�μ���ָ��, ���ȡ��ֵ, ����ָ��.
%Input:
%       A:���ƾ���size(A)=n*n
%       k:�������
%Output:
%       CA:����׼ȷ��
%       NMI: ��һ������Ϣ
%       AR: ��������ָ��
%       F: F1
%       P: precision
%       R: recall

N = size(A,1); % ������

DN = diag( 1./sqrt(sum(A)+eps) );  % �Ⱦ���
LapN = speye(N) - DN * A * DN;  % �Գƹ�һ��
[~,~,vN] = svd(LapN);
kerN = vN(:,N-k+1:N);  % ѡ��С��k������ֵ��Ӧ����������
normN = sum(kerN .^2, 2) .^.5;
kerNS = bsxfun(@rdivide, kerN, normN + eps);  % ���䰴�б�׼��
 
[CA, NMI, AR, F, P, R] = performKmeans(kerNS,k,truth);  % ִ��kmeans, ����ָ��

