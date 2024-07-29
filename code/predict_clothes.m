function predict = predict_clothes()

    model_files = {'top_model.mat', 'bottom_model.mat', 'dress_model.mat'};
    model_names = {'customized_top_model', 'customized_bottom_model', 'customized_dress_model'};
    model_vars = {'top_model', 'bottom_model', 'dress_model'};
    
    top_classes = {'short_sleeved_shirt', 'long_sleeved_shirt', 'short_sleeved_outwear', ...
                            'long_sleeved_outwear', 'vest', 'sling'};
    bottom_classes = {'shorts', 'trousers', 'skirt'};
    dress_classes = {'short_sleeved_dress', 'long_sleeved_dress', 'vest_dress', 'sling_dress'};
    
    for i = 1:length(model_files)
        model_path = fullfile('../model/Clothes_Classification/customized_model', model_files{i});
        loadData = load(model_path);
        if strcmp(model_names{i}, 'customized_top_model')
            top_model = loadData.(model_names{i});
        elseif strcmp(model_names{i}, 'customized_bottom_model')
            bottom_model = loadData.(model_names{i});
        elseif strcmp(model_names{i}, 'customized_dress_model')
            dress_model = loadData.(model_names{i});
        end
    end
    
    select = input('Please select a clothing type: \n 1 - tops and bottoms \n 2 - dress \n Select: ', 's');
    fprintf('\n');
    val1 = input("Enter the average temperature(°C) : ");
    val2 = input("Enter the daily rainfall amount(mm) : ");
    val3 = input("Enter average wind speed(m/s) : ");
    val4 = input("Enter the average relative humidity(%) : ");
    val5 = input("Enter the average total cloud amount(1/10) : ");
    
    data = {val1, val2, val3, val4, val5};
    data_matrix = cell2mat(data)';
    
    if select == '1'
        top_predict = top_model(data_matrix);
        [~, top_maxIdx] = max(top_predict);
        top_predicted = top_classes{top_maxIdx};
    
        bottom_predict = bottom_model(data_matrix);
        [~, bottom_maxIdx] = max(bottom_predict);
        bottom_predicted = bottom_classes{bottom_maxIdx};
    
        fprintf("Recommended tops and bottoms: %s, %s\n", top_predicted, bottom_predicted);
    
    elseif select == '2'
        dress_predict = dress_model(data_matrix);
        [~, dress_maxIdx] = max(dress_predict);
        dress_predicted = dress_classes{dress_maxIdx};
    
        fprintf("Recommended dress: %s\n", dress_predicted);
    end

end