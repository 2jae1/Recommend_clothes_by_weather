function [top_dataset, bottom_dataset, dress_dataset] = classify_clothes_dataset(photo_dir)

    pre_dataset = clothes_classification(photo_dir);
    
    top_dataset = [];
    bottom_dataset = [];
    dress_dataset = [];
    
    numRows = size(pre_dataset, 1);
    
    for i = 1:numRows
        if strcmp(pre_dataset{i,2}, 'top')
            top_dataset = [top_dataset; pre_dataset(i,[1,3])];
        elseif strcmp(pre_dataset{i,2}, 'bottom')
            bottom_dataset = [bottom_dataset; pre_dataset(i,[1,3])];
        elseif strcmp(pre_dataset{i,2}, 'dress')
            dress_dataset = [dress_dataset; pre_dataset(i,[1,3])];
        end
    
    end
end