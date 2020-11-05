clc,clear

data = xlsread('dataset_skripsi.xlsx');
% data = minMaxNorm(data);
numberOfClust = 2;

[iteration, result, distCentroid, lastCentroid] = kmeans2(data, numberOfClust, 'Variance', 'Euclidean Distance');
% [result,lastCentroid] = kmeans(data,2,'Distance','city');
% figure;
% plot(data(result==1,1),data(result==1,2),'r.','MarkerSize',12)
% hold on
% plot(data(result==2,1),data(result==2,2),'b.','MarkerSize',12)
% plot(lastCentroid(:,1),lastCentroid(:,2),'kx',...
%      'MarkerSize',15,'LineWidth',3) 
% legend('Cluster 1','Cluster 2','Centroids',...
%        'Location','NW')
% hold off
% figure
% gscatter(data(:,1),data(:,2),result,'bg')
% hold on
% plot(lastCentroid(:,1),lastCentroid(:,2),'kx')
% legend('Cluster 1','Cluster 2','Cluster Centroid')
eva = evalclusters(data,result,'silhouette');

% silhouette(data,result)