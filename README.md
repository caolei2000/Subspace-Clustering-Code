# Subspace-Clustering-Code

 code for some subspace clustering algorithm

 ## GPCA

一种代数方法, 相当于用多项式去拟合, 细节还没搞懂.

```matlab
[group, c, Dpn, Ln] = GPCA(x, n, method)

Input:
    x: 输入的数据, size(x)=d*n;
    n: 聚类簇数;
    method: 计算亲和矩阵的准则;
             'Cos'
             'Cos^2'
             'Exp_-sin^2'
Output:
    idx: 即最终聚类索引, size(idx)=n*1;
    c: 拟合的多项式的系数, size(c)=未知*1;
    Dpn: 每个样本点的单位长度法线估计, size(Dpn)=未知*n;
    Ln: 样本点的维罗纳式嵌入, size(Ln)=n*未知;
```

## 
