function [data, encodedLabel] = prepareData_deepfashion(labelLocation,imageLocation,categoriesTrain,inputSize,doAugmentation)

    miniBatchSize = 32;

    % Extract labels.
    % strData = fileread(labelLocation);
    % dataStruct = jsondecode(strData);
    dataStruct = labelLocation;

    numClasses = length(categoriesTrain);

    % Find images that belong to the subset categoriesTrain using
    % the COCOImageID function, attached as a supporting file.
    images = cell(numClasses,1);
    for i=1:numClasses
        images{i} = COCOImageID(categoriesTrain(i),dataStruct);
    end

    % Find the unique images.
    imageList = [images{:}];
    imageList = unique(imageList);
    numUniqueImages = numel(imageList);

    % Encode the labels.
    encodedLabel = zeros(numUniqueImages,numClasses);
    imgFiles = strings(numUniqueImages,1);
    for i = 1:numUniqueImages
        imgID = imageList(i);
        imgFiles(i) = fullfile(imageLocation + "\" + pad(string(imgID),6,"left","0") + ".jpg");

        for j = 1:numClasses
            if ismember(imgID,images{j})
                encodedLabel(i,j) = 1;
            end
        end
    end

    % Define the image augmentation scheme.
    imageAugmenter = imageDataAugmenter( ...
        RandRotation=[-45,45], ...
        RandXReflection=true);

    % Store the data in a table.
    dataTable = table(Size=[numUniqueImages 2], ...
        VariableTypes=["string" "double"], ...
        VariableNames=["File_Location" "Labels"]);

    dataTable.File_Location = imgFiles;
    dataTable.Labels = encodedLabel;

    % Create a datastore. Transform grayscale images into RGB.
    if doAugmentation
        data = augmentedImageDatastore(inputSize(1:2),dataTable, ...
            ColorPreprocessing="gray2rgb", ...
            DataAugmentation=imageAugmenter);
    else
        data = augmentedImageDatastore(inputSize(1:2),dataTable, ...
            ColorPreprocessing="gray2rgb");
    end
    data.MiniBatchSize = miniBatchSize;
end