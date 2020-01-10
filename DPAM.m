% CMAD is a three stage clustering algorithm,
% it does not depend on whether there are reasonable parameters,
% and get accurate and robust results.
% written by Yizhang Wang 2017
% 2017 03 23
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;clear;close all
addpath('D:\MEGAFile\work\evaluation', 'D:\MEGAFile\work\Complicate','D:\MEGAFile\work\UCI','D:\MEGAFile\work\drawGraph');
addpath('D:\MEGAFile\work\Celldata');
load('iris.mat');
% load('E:\MEGAFile\work\Complicate\Jain.mat');


T=data;
Row = size(T,1);
Col = size(T,2);
D = pdist(T); %欧式距离
DM=squareform(D); %将D还原为距离矩阵
S=-DM;
%% 偏向参数的设置
N=size(S,1); %对象的个数
meds = max(S(:));            %S(:)是将S矩阵变换成一个矢量，然后调用median函数取中值
mins= mean(min(S(:)));
find (S==mins)
for i = 1:N
     S(i,i)=0.1*mins; %S(i,i)的值选取对聚类精度至关重要
  %  S(i,i)=0.05*mins; %S(i,i)的值选取对聚类精度至关重要
end
%% A(i,k)和R(i,k)信息迭代
ar_update
%% Sil有效性指标及聚类结果
result;
%% 绘出ap聚类图
% Ex_evaluation
drawAP
 set(gca,'looseInset',[0 0 0 0]);
%% 第二阶段，生出主体聚类图
oldidx=c;
iter=0;
Den=[];
oldDen=0;%记录上一个子类的局部密度
icluster=[];
for i=unique(idx)'
    sum=0;
    iter=iter+1;
    ii=find(idx==i);%ii每个类的序号
    icluster{iter}=ii;
end
iclen=length( icluster);
oldcluster=[1:iclen];
temp=oldcluster(1);%temp存储当前的类号
iter=0;
%% 合并阶段
bigcluster=[icluster{temp}];%存储当前合并的类
while ~isempty(oldcluster)
    iter=iter+1;
    temp_DM=DM;%局部相似度
    %  fprintf('---------------------------------------\n');
    % 先求距离本类最近的一个点所在的类
    %% 本类和求离他最近的下一类，sminEdu是最短距离
    icluster{temp};
    bigcluster;% 1所有已经合并的类离下一个最近类的最短聚类.2另外一种做法，也可以聚类后的数据再跑一次这个程序）
    irow=temp_DM(icluster{temp},:);%irow是第j类所有点在相似度矩阵中的所有行
    %irow中第j类和其他类的点最短的距离
    irow(:,[bigcluster])=inf;
    [Y U]=min(irow,[],2);
    [Y1 U1]=min(Y) ;   %    U1 是本类所在数据点序号
    newdat=oldidx(U(U1));  %    newdat是下一类的数据点序号
    sminEdu=Y1;
    %% 本类点之间最短距离中的最大值，omaxEdu是类内最大距离
    D2 = pdist(T(icluster{temp},:));
    DM2=squareform(D2); %将D还原为距离矩阵
    %   DM2 (DM2==0)=inf;%把DM矩阵中的0元素变成最大
    %omaxEdu是本类中，每一个点与其他点的最短距离，选最大的。
    Dm2i=max(DM2);
    omaxEdu=max(Dm2i);
    if sminEdu<omaxEdu
        idx(icluster{newdat},:)=min(idx(icluster{temp},:));
        %         fprintf('第%d类 和第%d类合并 第%d次循环 \n',temp,newdat,iter);
        %% 符合合并要求后的操作
        oldcluster(temp)=0;
        bigcluster=[bigcluster
            icluster{newdat}];
        temp = newdat;
    else
        %         fprintf('第%d类 断开第%d次循环  \n',temp,iter);
        oldcluster(temp)=0;
        pp=find(oldcluster~=0);
        if isempty (pp)
            break;
        end
        temp=pp(1);
    end
end
% Ex_evaluation
drawAP
 set(gca,'looseInset',[0 0 0 0]);
%% 第三阶段  完成最终聚类
if isequal(var(Den),0)
    return;
end
ys=0
for i=1:1000
    GetDesi;
    save{i}=idx
    fprintf('第%d次循环 %d \n',i,length(unique(idx)));
    var(Den)
    if isequal(var(Den),0)
        idx=save{i-1};
        ys=1;
        break;
    else
        Getshortedu;       
    end
    if ys==1
        break;
    end
end
%% 聚类指标
%sil=mean(silhouette(T,c))
%% 绘出新聚类图
% drawAP
 set(gca,'looseInset',[0 0 0 0]);
%% 外部评价指标
Evaluation(label,idx);
