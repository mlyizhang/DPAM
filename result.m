%% 输出聚类结果
fprintf('迭代次数：%d   \n',iter);
E=R+A; % Pseudomarginals
I=find(diag(E)>0);
K=length(I);% Indices of exemplars
[tmp c]=max(E(:,I),[],2);
% K=length(unique(c))
c(I)=1:K;                 %%替换自身所在的位置
idx=I(c); % Assignments   %%找出N个样本点所对应的中心点
disp('AP聚类结果如下：\n');
disp('------------------');
fprintf('类数为：%d   \n',K);
% fprintf('类的中心点和所包含的对应点如下：\n');
% disp('-----------------------------');
% counter = 0;
% for i=1:K
%     m=I(i); 
%     Set(Row,Col) = 0;
%     disp('-----------------------------');
%     fprintf('第 %d 个中心点: E(%d)=%6.4f \n',i,m,E(m,m));
%     disp('-----------------------------');
%     
%     Count(K) = 0;
%     for j=1:N
%         n = idx(j);      %%各样本点所对应的中心点位置
%         if(n == m) 
%             fprintf('S中第 %d 个样本点聚到该中心点下 \n',j);   %%打印此次中心点所包含的样本点
%             counter = counter + 1;
%             Set(counter,:) = T(j,:);
%         end
%     end
%     Count(i) = counter;
% end
% Number(K) = 0;
% Number(1) = Count(1);
% for i = 2:K
%     Number(i) = Count(i) - Count(i - 1);  %计算每个类包含的点数
% end
% %% 计算Sil有效性指标
% Sil(N,1) = 0;
% for i = 1 : N
%     Tcopy = repmat(T(i,:),N,1); %得到矩阵 Tcopy 行向量全部为 T 矩阵中i行数据 
%     Cha = Tcopy - T;
%     for j = 1 : N
%         PF(j,1) = Cha(j,:) * Cha(j,:)'; %平方和
%     end
%     Dist = sqrt(PF);
%     for t = 1:K
%         SU(t,1) = 0;
%         Ave(t,1) = 0;
%     end
%     
%     for z = 1 : K
%         if z == 1 
%             for k = 1 : Count(z)
%               SU(z) = Dist(k) + SU(z);
%             end
% %             Ave(z) = SU(z) / Number(z);
%         else
%             for n = (Count(z - 1) + 1) : Count(z)
%                 SU(z) = Dist(n) + SU(z);
%             end
% %             Ave(z) = SU(z) / Number(z);
%         end
%     end
% %     SU
%     for z = 1 : K
%         if c(i) == z
%             if Number(z)==1
%                 at=0;
%             else
%             Ave(z) = SU(z) / (Number(z) - 1);
%             at = Ave(z);
%             end
%         else
%             Ave(z) = SU(z) / Number(z);
%         end
%     end
%     Ave(c(i)) = 100000;
%     bt = min(Ave);
%     Sil(i,1) = (bt - at) / max(at , bt);       
% end
% Silhouette = sum(Sil) / N