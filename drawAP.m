%% 画出聚类图
figure; 
% plot([xl xr],[0,0],'k',[0,0],[yb yt],'k');
if Col==3
    for i=unique(idx)'
        ii=find(idx==i);
        h=plot3(T(ii,1)',T(ii,2)',T(ii,3)','*'); 
        hold on;
        col=rand(1,3);  
        set(h,'Color',col,'MarkerFaceColor',col);
        Ti1=T(i,1)*ones(size(ii));
        Ti2=T(i,2)*ones(size(ii));
        Ti3=T(i,3)*ones(size(ii));
        x=[T(ii,1),Ti1];
        y=[T(ii,2),Ti2];
        z=[T(ii,3),Ti3];
        plot3(x',y',z','color',col)
        grid on
    end
else
    iter=0;
    set(gcf,'color','none');
    for i=unique(idx)'
        iter=iter+1;
        ii=find(idx==i);
        h=plot(T(ii,1)',T(ii,2)','.','MarkerSize',15); 
        hold on;
        col=rand(1,3);  
        set(h,'Color',col,'MarkerFaceColor',col);
%         text(T(ii,1),T(ii,2),num2str(iter))  
        Ti1=T(i,1)*ones(size(ii));
        Ti2=T(i,2)*ones(size(ii));
        x=[T(ii,1),Ti1];
        y=[T(ii,2),Ti2];
        plot(x',y','.','color',col)
% title(['CMAD Clustering: None Parameters']);
    end
end
%% 画出类中心点和K-远离点
% figure
% for i=1:K
%     col=rand(1,3);
%     plot(T(I(i),1),T(I(i),2),'*','color',col);
%     hold on 
%     for j=1:KFN(i)
%         plot(T(si(i,j),1),T(si(i,j),2),'.','color',col);
%         hold on
%         plot([T(I(i),1),T(si(i,j),1)],[T(I(i),2),T(si(i,j),2),],'color',col);
%         hold on
%     end
% end