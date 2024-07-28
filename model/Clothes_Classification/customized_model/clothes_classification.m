function clothes_info = clothes_classification(photo_dir)
    % Input directory of clothes
    dir_path = fullfile(photo_dir);
    clothes_list = dir(dir_path);
    clothes_list = clothes_list(~ismember({clothes_list.name}, {'.', '..'}));
    
    % load network, save infomation
    trainedNet = importONNXNetwork('../../Multilabel_Image_Classification/trainedNet.onnx');
    inputSize = trainedNet.Layers(1).InputSize; thresholdValue = 0.5;
    clothes = ["short_sleeved_shirt" "long_sleeved_shirt" ...
        "short_sleeved_outwear" "long_sleeved_outwear" "vest" "sling" ...
        "shorts" "trousers" "skirt" "short_sleeved_dress" ...
        "long_sleeved_dress" "vest_dress" "sling_dress"];
    clothes_type = ["top" "top" "top" "top" "top" "top" "bottom" "bottom" ...
        "bottom" "dress" "dress" "dress" "dress"];
    dic = dictionary(clothes, clothes_type);
    
    % Clothes classification
    clothes_info = [];
    for k = 1:length(clothes_list)
        file_name = clothes_list(k).name;
        img_path = fullfile(dir_path, file_name);
        img = imread(img_path);
        img = imresize(img,inputSize(1:2));
    
        scoresImg = predict(trainedNet,img)';
        YPred =  clothes(scoresImg >= thresholdValue);
    
        for i = 1:length(YPred)
            data = [file_name, dic(YPred(i)), YPred(i)];
            clothes_info = [clothes_info; data];
        end
    end
end