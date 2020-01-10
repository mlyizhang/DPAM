% 求各个子类的线性密度线性密度
kcluster={};
 Den=[];
%     fprintf('final-----clustering------ \n');
    ite=0;
    k=unique(idx);
for k=unique(idx)'
    kk=find(idx==k);
      sum=0;
    ite=ite+1;
    kcluster{ite}=kk;
    D1 = pdist(T(kk,:)); %欧式距离
    DM1=squareform(D1);%将D还原为距离矩阵
    for j=1:length(kk)-1
        sum=sum+DM1(j,j+1);
    end
    Den(ite,:)=(length(kk)/size(data,1))*sum/length(kk); % 区域密度计算方式
    
end