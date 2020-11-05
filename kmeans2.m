function [iteration, result, distCentroid, tempCentroid] = kmeans2(data, numberOfClust, method, distance)
format short g

[x,y] = size(data);
centroid = centroidMethod(data,numberOfClust,method);

[clustC,clustR] = size(centroid);
tempCentroid = centroid;
distCentroid = zeros(x,clustC);
tempData = distCentroid;
tempResult = [];
result = [];
i=1;
iteration = 1;
    while(i <= x)
        for j=1:clustC
            temp = 0;
            if(strcmp(distance, 'Euclidean Distance') == 1)
                for k=1:y
                    temp = temp + (tempCentroid(j,k) - data(i,k))^2;
                end
                tempData(i,j) = sqrt(temp);
            elseif(strcmp(distance, 'Manhattan Distance') == 1)
                for k=1:y
                    temp = temp + (abs(tempCentroid(j,k) - data(i,k)));
                end
                tempData(i,j) = temp;
            elseif(strcmp(distance, 'Cosine Distance') == 1)
                cs_num = sum(data(i,:).*tempCentroid(j,:));
                cs_den = sqrt(sum(data(i,:).*data(i,:))) * sqrt(sum(tempCentroid(j,:).*tempCentroid(j,:)));
                cosa = cs_num/cs_den;
                cosa = str2num(sprintf('%0.4f', cosa));
                temp = 1 - cosa;
                tempData(i,j) = temp;
            end
        end
        
        minimum = tempData(i,1);
        index = 1;
        for j=1:clustC
            if tempData(i,j) < minimum
                minimum = tempData(i,j);
                index = j;
            end
        end

        tempResult = [tempResult;index];

        if i == x
            if tempData == distCentroid
                distCentroid = tempCentroid;
                result = tempResult;
                break;
            else
                iteration = iteration + 1;
                distCentroid = tempData;
                i = 1;
                tempCentroid = [];
                t = tempResult;
                for m = 1:clustC
                    cc = find(t == m);
                    tempCentroid = [tempCentroid;mean(data(cc,:),1)];
                end
                tempResult = [];
            end
        else
            i = i+1;
        end
    end
end