function model = make_customized_model(dataset, model,kind)
    if isempty(dataset)
        return;
    end

    new_data = cell2mat(dataset(:, 1:end-1)')';
    new_label = dataset(:, end);
    new_label = string(new_label);
    
    existing_top_classes = {'short_sleeved_shirt', 'long_sleeved_shirt', 'short_sleeved_outwear', ...
                        'long_sleeved_outwear', 'vest', 'sling'};
    existing_bottom_classes = {'shorts', 'trousers', 'skirt'};
    existing_dress_classes = {'short_sleeved_dress', 'long_sleeved_dress', 'vest_dress', 'sling_dress'};

    switch kind
        case 'top'
            existing_classes = existing_top_classes;
        case 'bottom'
            existing_classes = existing_bottom_classes;
        case 'dress'
            existing_classes = existing_dress_classes;
    end

    new_labels = categories(categorical(new_label));
    all_labels = unique([new_labels; existing_classes']); 
    
    num_classes = numel(all_labels);
    label_map = containers.Map(all_labels, 1:num_classes);
    
    % making label index
    new_label_numeric = zeros(size(new_label));
    for i = 1:length(new_label)
        new_label_numeric(i) = label_map(new_label(i));
    end
    
    % one-hot encoding
    label_one_hot = full(ind2vec(new_label_numeric', num_classes));
    
    % model customize by personal data
    model.trainParam.epochs = 50; % 추가 학습을 위한 epoch 설정 (필요에 따라 조정)
    model = train(model, new_data', label_one_hot);

end
