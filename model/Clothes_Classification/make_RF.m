function model = make_RF(dataset)
    data = cell2table(dataset);
 
    label_column = 'dataset6'; % Choose Label column
    X = data;
    y = data.(label_column);
    y = categorical(y); % Change label to category

    X.(label_column) = []; 
    X = table2array(X);
    y = double(y);
    
    % Make RandomForest model
    num_trees = 100;
    model = TreeBagger(num_trees, X, y, 'OOBPrediction', 'on', 'Method', 'classification');
   
end