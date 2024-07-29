function net = make_ANN(dataset)
    data = cell2mat(dataset(:, 1:end-1)')';
    label = dataset(:, end);
    label = string(label);
    
    categorical_labels = categorical(label);
    unique_labels = categories(categorical_labels); % 유일한 레이블을 추출
    label_numeric = double(categorical_labels); % 숫자 인덱스 변환
    
    num_classes = numel(unique_labels); % 클래스 수
    label_one_hot = full(ind2vec(label_numeric', num_classes)); % one-hot 인코딩
    
    net = patternnet([10, 10, 10],'trainrp');
    net.trainParam.epochs = 1000;
    net.trainParam.lr = 0.1;
    % 신경망 훈련
    net = train(net, data', label_one_hot);
end