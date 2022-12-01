# Subspace-Clustering-Code

 code for some subspace clustering algorithms

 使用方法: 运行 `run_YaleB.m` 文件. 里面主要是进行了加载数据集, 预处理, 调用 `xxx()` 对应算法, 然后 `ComputeMetrics()` 计算指标.

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

## RANSAC

一种统计方法, 类似随机不断选择的意思. 这个算法可用于很多任务, 之前视觉课上讲了这个方法用于"边缘检测"任务中的"拟合边缘".

```matlab
[group, b]=RANSAC(x, d, n, t)

Input:
    x: 输入数据, size(x)=d*n;
    d: 要找到的子空间的维度;
    n: 聚类簇数(子空间数量)
    t: 一个阈值参数(应该是判定为内点的?)
Output:
    group: 最终聚类索引, size(group)=n*1;;
    b: 暂时不懂什么意思, 先不管;
```
