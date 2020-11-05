function [tempCentroid] = centroidMethod(data,numberOfClust,method)

if(strcmp(method,'Random') == 1)
    idx = randperm(size(data,1),numberOfClust);
    centroid = data(idx,:);
elseif(strcmp(method,'Random') == 0)
    [x,y] = size(data);
    centro = [];

    for j=1:x
        temp = 0;
        for i=1:y
            temp = temp + (data(j,i));
        end
    centro = [centro;temp];
    end

    minVal=0;
    idx = zeros(1,numberOfClust);
        if(strcmp(method,'Maximal Value') == 1)
            for j=1:numberOfClust
                [minVal,index] = max(centro);
                centro(index) = [];
                idx(j) = index;
            end
            centroid = data(idx,:);
        elseif(strcmp(method,'Minimal Value') == 1)
            for j=1:numberOfClust
                [minVal,index] = min(centro);
                centro(index) = [];
                idx(j) = index;
            end
            centroid = data(idx,:);
        elseif(strcmp(method,'Variance') == 1)
            tempData2 = [];
            stand = [];

            for j = 1:y
                tempData2 = [];
                for i = 1:x
                    tempData2(1,i) = data(i,j);
                end
                stand = [stand;std(tempData2)];
            end

            maks = max(stand);
            idx = find(stand==maks);

            if length(maks) > 1
                idx = randperm(length(idx),1);
            end

            dataSort = sortrows(data,idx);

            temp = [];
            ro = (round(x/numberOfClust));
            tempCentroid2 = [];
            centroid = [];

            if numberOfClust == 2
               for i = 1:x
                    if (i == (ro+1)) || (i == x) 
                        for j = 1:y
                            tempCentroid2 = [tempCentroid2;median(temp(:,j))];
                        end
                        centroid = [centroid;tempCentroid2'];
                        temp = [];
                        tempCentroid2=[];
                    end
                    temp = [temp;dataSort(i,:)];
                end
            elseif numberOfClust == 3
                for i = 1:x
                    if (i == (ro+1)) || (i == ((ro*2)+1)) || (i == x) 
                        for j = 1:y
                            tempCentroid2 = [tempCentroid2;median(temp(:,j))];
                        end
                        centroid = [centroid;tempCentroid2'];
                        temp = [];
                        tempCentroid2=[];
                    end
                    temp = [temp;dataSort(i,:)];
                end
            end
        end
end
    
[clustC,clustR] = size(centroid);
tempCentroid = centroid;

end