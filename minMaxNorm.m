function [NormData] = minMaxNorm(data)
[x,y] = size(data);
NormData = [];

    for i=1:x
        for j=1:y
            NormData(i,j) = ((data(i,j)-min(data(:,j)))/(max(data(:,j)-min(data(:,j))))) * (1-0) + 0;
        end
    end

end

