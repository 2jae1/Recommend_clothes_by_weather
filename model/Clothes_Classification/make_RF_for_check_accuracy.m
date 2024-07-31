function model = make_RF_for_check_accuracy(dataset)
    data = cell2table(dataset);
 
    label_column = 'dataset6'; % Choose Label column
    X = data;
    y = data.(label_column);
    y = categorical(y); % Change label to category

    X.(label_column) = []; 
    X = table2array(X);
    y = double(y);
    
    % Split to train & test data
    numRows = height(data);
    indices = randperm(numRows);
    
    % 80% train data, 20% test data
    numTrain = round(0.8 * numRows);
    trainIndices = indices(1:numTrain);
    testIndices = indices(numTrain+1:end);
    
    X_train = X(trainIndices, :);
    X_test = X(testIndices, :);
    y_train = y(trainIndices);
    y_test = y(testIndices);
    
    % Make RandomForest model
    num_trees = 100;
    model = TreeBagger(num_trees, X, y, 'OOBPrediction', 'on', 'Method', 'classification');
    
    % Predict by test data
    y_pred = predict(model, X_test);
    y_pred = double(categorical(y_pred)); 
    
    % Calculate accuracy
    accuracy = sum(y_pred == y_test) / numel(y_test);
    fprintf('Accuracy: %.2f\n', accuracy);
    
    % Calculate confusionmatrix
    confMatrix = confusionmat(y_test, y_pred);
    classNames = unique(y_test);

    report = struct();
    report.ConfusionMatrix = confMatrix;
    report.ClassNames = classNames;
    disp(report);
end