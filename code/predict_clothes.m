function output = predict_clothes()
    model_files = {'top_model.mat', 'bottom_model.mat', 'dress_model.mat'};
    model_names = {'top_model', 'bottom_model', 'dress_model'};
    
    top_classes = {'short_sleeved_shirt', 'long_sleeved_shirt', 'short_sleeved_outwear',...
        'long_sleeved_outwear', 'vest', 'sling'};
    bottom_classes = {'shorts', 'trousers', 'skirt'};
    dress_classes = {'short_sleeved_dress', 'long_sleeved_dress', 'vest_dress', 'sling_dress'};
    
    top_classes_idx = double(categorical(top_classes));
    bottom_classes_idx = double(categorical(bottom_classes));
    dress_classes_idx = double(categorical(dress_classes));
    
    for i = 1:length(model_files)
        model_path = fullfile('../model/Clothes_Classification', model_files{i});
        loadData = load(model_path);
        if strcmp(model_names{i}, 'top_model')
            top_model = loadData.(model_names{i});
        elseif strcmp(model_names{i}, 'bottom_model')
            bottom_model = loadData.(model_names{i});
        elseif strcmp(model_names{i}, 'dress_model')
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
    data_matrix = cell2mat(data);
    
    if select == '1'
        top_predict_idx = predict(top_model,data_matrix);
        top_predict_idx = double(categorical(top_predict_idx));
        top_predict_num = find(top_classes_idx == top_predict_idx);
        top_predict = top_classes(top_predict_num);
    
        bottom_predict_idx = predict(bottom_model,data_matrix);
        bottom_predict_idx = double(categorical(bottom_predict_idx));
        bottom_predict_num = find(bottom_classes_idx == bottom_predict_idx);
        bottom_predict = bottom_classes(bottom_predict_num);
    
        fprintf("Recommended tops and bottoms: %s, %s\n", top_predict{1}, bottom_predict{1});
    
    elseif select == '2'
        dress_predict_idx = predict(dress_model,data_matrix);
        dress_predict_idx = double(categorical(dress_predict_idx));
        dress_predict_num = find(dress_classes_idx == dress_predict_idx);
        dress_predict = dress_classes(dress_predict_num);
    
        fprintf("Recommended dress: %s\n", dress_predict{1});
    end
end