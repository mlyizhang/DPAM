% 求任意两个子类的最小点距离的矩阵，并重新计算和分配标签
for j=1:length(Den)
    for k=1:length(Den)
        irow=temp_DM(kcluster{j},kcluster{k});%irow是第j类所有点在相似度矩阵中的所有行
        [Y U]=min(irow,[],2);% Y 每一行的最小值
        [Y2 U2]=min(Y);  %    U1 是本类所在数据点序号
        short(j,k)=Y2;
    end
end
maxmean=find(Den>mean(Den));
short=short(:,find(Den>mean(Den)));
short(short==0)=inf;
[Y3 U3]=min(short,[],2);% Y 每一行的最小值
for j=1:length(Den)
    if Den(j)<mean(Den)
%         kcluster{maxmean(U3(j))}
        idx(kcluster{j},:)=idx(kcluster{maxmean(U3(j))}(1));
    end
end