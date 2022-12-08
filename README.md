# Subspace-Clustering-Code

 code for some subspace clustering algorithms

 使用方法: 运行 `run_YaleB.m` 文件. 里面主要是进行了加载数据集, 预处理, 调用 `xxx()` 对应算法, 然后 `ComputeMetrics()` 计算指标.

 ## GPCA

一种代数方法, 相当于用多项式去拟合, 细节还没搞懂.

```matlab
[idx, c, Dpn, Ln] = GPCA(x, n, method)

Input:
    x: 输入的数据, size(x)=d*n;
    n: 聚类簇数(子空间数目);
    method: 计算亲和矩阵的准则;
             'Cos'
             'Cos^2'
             'Exp_-sin^2'
Output:
    idx: 聚类结果索引, size(idx)=n*1;
    c: 拟合的多项式的系数, size(c)=未知*1;
    Dpn: 每个样本点的单位长度法线估计, size(Dpn)=未知*n;
    Ln: 样本点的维罗纳式嵌入, size(Ln)=n*未知;
```

## RANSAC

一种统计方法, 类似随机不断选择的意思. 这个算法可用于很多任务(相当于一种思想), 之前视觉课上讲了这个方法用于"边缘检测"任务中的"拟合边缘". 注意这个算法不会用到谱聚类.

```matlab
[idx, b]=RANSAC(x, d, n, t)

Input:
    x: 输入数据, size(x)=d*n;
    d: 要找到的子空间的维度;
    n: 聚类簇数(子空间数目)
    t: 判定为模型内点的阈值
Output:
    idx: 聚类结果索引, size(idx)=n*1;
    b: 暂时不懂什么意思, 先不管;
```

## SSC

```matlab
[idx,CMat] = SSC(X, r, affine, alpha, outlier, rho, k)

Input: 
    X: 数据, size(X)=n*d;
    r: 使用PCA进行映射降维后的维度, 若r=0, 则不降维(通常取0);
    affine: bool, 是否进行仿射变换(意义暂时未懂);
    outlier: bool, 是否添加离群项约束(对结果有较大影响);
    rho: 暂时未懂(对结果影响不大);
    k: 聚类簇数(子空间数目);
Output:
    idx: 聚类结果索引, size(idx)=n*1;
    CMat: SSC得到的稀疏系数矩阵, size(CMat)=n*n;
```

## utils

介绍 `utils` 目录下可能需要用到或者理解的函数


```matlab
[idx, center, kerNS] = SpectralClustering(sM, k)

Input:
    sM:相似度矩阵，size(sM)=n*n;
    k:聚类簇数;
Output:
    idx: 每个样本归属的簇索引,即聚类结果索引,从1开始, size(idx)=n*1;
    center: 每个簇的中心点坐标, size(center)=k*k;
    kerNS: 最后未进行kmeans的谱聚类得到的指示矩阵, size(kerNS)=n*k;
```

```matlab
[ca, nmi, ar, f1, p, r] = ComputeMetrics(gnd, idx)

Input:
    gnd: ground truth, size(gnd)=n*1;
    idx: 算法得到的聚类结果索引, size(idx)=n*1;
Output:
    ca: 聚类精度;
    nmi: 归一化互信息;
    ar: 调整兰德指数;
    f1: F1 score;
    p: precision;
    r: recall;
```