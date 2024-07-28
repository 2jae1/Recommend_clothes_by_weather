function [top_dataset, bottom_dataset, dress_dataset] = devide_clothes_dataset(dataset)

top_dataset = [];
bottom_dataset = [];
dress_dataset = [];

numRows = size(dataset, 1);

for i = 1:numRows
    if strcmp(dataset{i,6}, 'top')
        top_dataset = [top_dataset; dataset(i,[1:5,7])];
    elseif strcmp(dataset{i,6}, 'bottom')
        bottom_dataset = [bottom_dataset; dataset(i,[1:5,7])];
    elseif strcmp(dataset{i,6}, 'dress')
        dress_dataset = [dress_dataset; dataset(i,[1:5,7])];
    end
end

end