function [NormData] = zscore(data)
    [x,y] = size(data);
    NormData = [];

    mean = sum(sum(data))/(x*y);
    measure = [];
    for i = 1:y
        for j = 1:x
             measure(j,i) = data(j,i)- mean;
        end
    end

    kuadrat = [];
    for i = 1:y
        for j = 1:x
              kuadrat(j,i) = measure(j,i)^2;
        end
    end

    square = sum(sum(kuadrat));

    var = square/(y-1);

    std = sqrt(var);

    NormData =[];
    for i = 1:y
        for j = 1:x
           NormData(j,i) = (data(j,i)-mean)/std;
        end
    end

end

