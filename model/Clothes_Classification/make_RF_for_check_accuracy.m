function model = make_RF(dataset)
    data = cell2table(dataset);
    
    % 레이블 열 지정
    label_column = 'dataset6';
    
    % 특성과 레이블 분리
    X = data;
    y = data.(label_column);
    
    % 레이블을 숫자로 변환
    y = categorical(y); % 범주형 변수로 변환
    
    % 특성 데이터만 선택하고 array로 변환
    X.(label_column) = []; % 레이블 열 제거
    X = table2array(X); % table 형식을 array 형식으로 변환
    
    % 레이블도 array 형식으로 변환
    y = double(y);
    
    % 학습 데이터와 테스트 데이터로 분할
    numRows = height(data);
    indices = randperm(numRows); % 데이터 인덱스를 무작위로 섞음
    
    % 80% 학습 데이터, 20% 테스트 데이터 분할
    numTrain = round(0.8 * numRows);
    trainIndices = indices(1:numTrain);
    testIndices = indices(numTrain+1:end);
    
    X_train = X(trainIndices, :);
    X_test = X(testIndices, :);
    y_train = y(trainIndices);
    y_test = y(testIndices);
    
    % 랜덤 포레스트 모델 초기화
    num_trees = 100;
    model = TreeBagger(num_trees, X_train, y_train, 'OOBPrediction', 'on', 'Method', 'classification');
    
    % 예측 수행
    y_pred = predict(model, X_test);
    y_pred = double(categorical(y_pred)); % 예측값을 double로 변환
    
    % 정확도 계산
    accuracy = sum(y_pred == y_test) / numel(y_test);
    fprintf('Accuracy: %.2f\n', accuracy);
    
    % 분류 보고서 출력
    % 혼동 행렬 계산
    % confMatrix = confusionmat(y_test, y_pred);
    
    % 클래스 레이블 추출
    classNames = unique(y_test); % 클래스 레이블 추출
    
    % 분류 보고서 출력
    % report = struct();
    % report.ConfusionMatrix = confMatrix;
    % report.ClassNames = classNames;
    % disp(report);
end