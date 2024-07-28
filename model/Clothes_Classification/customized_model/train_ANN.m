function net = train_ANN(dataset,model)
    data = cell2mat(dataset(:, 1:end-1)')';
    label = dataset(:, end);
    label = string(label);
    
    categorical_labels = categorical(label);
    unique_labels = categories(categorical_labels); % 유일한 레이블을 추출
    label_numeric = double(categorical_labels); % 숫자 인덱스 변환
    
    num_classes = numel(unique_labels); % 클래스 수
    label_one_hot = full(ind2vec(label_numeric', num_classes)); % one-hot 인코딩
    
    net = model;
    
    % 신경망 훈련
    net = train(net, data', label_one_hot);
end