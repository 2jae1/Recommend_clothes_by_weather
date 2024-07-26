%% Load Pretrained Network
net = resnet50;
inputSize = net.Layers(1).InputSize;

%% Prepare Data
categoriesTrain = ["short_sleeved_shirt" "long_sleeved_shirt" ...
    "short_sleeved_outwear" "long_sleeved_outwear" "vest" "sling" ...
    "shorts" "trousers" "skirt" "short_sleeved_dress" ...
    "long_sleeved_dress" "vest_dress" "sling_dress"];
numClasses = length(categoriesTrain);

labelLocationTrain = load('../../data/clothes_data/train_all.mat');
labelLocationTrain = labelLocationTrain.train;
imageLocationTrain = '../../data/clothes_data/train_image'; 

[dataTrain,encodedLabelTrain] = prepareData_deepfashion(labelLocationTrain,imageLocationTrain,categoriesTrain,inputSize,true);
numObservations = dataTrain.NumObservations;

labelLocationVal = load('../../data/clothes_data/validation_all.mat');  
labelLocationVal = labelLocationVal.validation;
imageLocationVal = '../../data/clothes_data/validation_image';

[dataVal,encodedLabelVal] = prepareData_deepfashion(labelLocationVal,imageLocationVal,categoriesTrain,inputSize,false);

%% Inspect Data
% numObservationsPerClass = sum(encodedLabelTrain,1);
% 
% figure
% bar(numObservationsPerClass)
% ylabel("Number of Observations")
% xticklabels(categoriesTrain)
% 
% numLabelsPerObservation = sum(encodedLabelTrain,2);
% mean(numLabelsPerObservation)
% 
% figure
% histogram(numLabelsPerObservation)
% hold on
% ylabel("Number of Observations")
% xlabel("Number of Labels")
% hold off

%% Adapt Pretrained Network for Transfer Learning
lgraph = layerGraph(net);

% Replace Last Learnable Layer
newLearnableLayer = fullyConnectedLayer(numClasses, ...
        Name="new_fc", ...
        WeightLearnRateFactor=10, ...
        BiasLearnRateFactor=10);
    
lgraph = replaceLayer(lgraph,"fc1000",newLearnableLayer);

% Replace Softmax Layer
newActivationLayer = sigmoidLayer(Name="sigmoid");
lgraph = replaceLayer(lgraph,"fc1000_softmax",newActivationLayer);

% Replace Output Layer
newOutputLayer = CustomBinaryCrossEntropyLossLayer("new_classoutput");
lgraph = replaceLayer(lgraph,"ClassificationLayer_fc1000",newOutputLayer);

%% Training Options
options = trainingOptions("sgdm", ...
    InitialLearnRate=0.0005, ...
    MiniBatchSize=32, ...
    MaxEpochs=10, ...
    Verbose= true, ...
    ValidationData=dataVal, ...
    ValidationFrequency=100, ...
    ValidationPatience=5, ...
    Plots="training-progress");

%% Train Network
trainedNet = trainNetwork(dataTrain,lgraph,options);
exportONNXNetwork(trainedNet,'trainedNet.onnx')

%% Assess Model Performance
% thresholdValue = 0.5;
% scores = predict(trainedNet,dataVal);
% YPred = double(scores >= thresholdValue);
% 
% % F1-score
% FScore = F1Score(encodedLabelVal,YPred);
% 
% % Jaccard Index
% jaccardScore = jaccardIndex(encodedLabelVal,YPred);
% 
% % Confusion Matrix
% figure
% tiledlayout("flow")
% for i = 1:numClasses
%     nexttile
%     confusionchart(encodedLabelVal(:,i),YPred(:,i));
%     title(categoriesTrain(i))
% end

%% Investigate Threshold Value
% thresholdRange = 0.1:0.1:0.9;
% 
% metricsName = ["F1-score","Jaccard Index","Precision","Recall"];
% metrics = zeros(4,length(thresholdRange));
% 
% for i = 1:length(thresholdRange)
% 
%     YPred = double(scores >= thresholdRange(i));
% 
%     metrics(1,i) = F1Score(encodedLabelVal,YPred);
%     metrics(2,i) = jaccardIndex(encodedLabelVal,YPred);
% 
%     [precision, recall] = performanceMetrics(encodedLabelVal,YPred);
%     metrics(3,i) = precision;
%     metrics(4,i) = recall;
% end
% 
% figure
% tiledlayout("flow")
% for i = 1:4
% nexttile
% plot(thresholdRange,metrics(i,:),"-*")
% title(metricsName(i))
% xlabel("Threshold")
% ylabel("Score")
% end

%% Predict Using New Data
% imageNames = ["../../data/personal_clothes_data/2023-08-20-여수.jpg" ...
%     "../../data/personal_clothes_data/2023-12-16-청주.jpg"];
% 
% figure
% tiledlayout(1,2)
% images = [];
% labels = [];
% scores =[];
% 
% for i = 1:2
%     img = imread(imageNames(i));
%     img = imresize(img,inputSize(1:2));
%     images{i} = img;
% 
%     scoresImg = predict(trainedNet,img)';
%     YPred =  categoriesTrain(scoresImg >= thresholdValue);
% 
%     nexttile
%     imshow(img)
%     title(YPred)
% 
%     labels{i} = YPred;
%     scores{i} = scoresImg;
% end
% 
% % Investigate Network Predictions
% imageIdx = 1;
% testImage = images{imageIdx};
% 
% tbl = table(categoriesTrain',scores{imageIdx},VariableNames=["Class", "Score"]);
% disp(tbl)