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
    
    % 랜덤 포레스트 모델 초기화
    num_trees = 100;
    model = TreeBagger(num_trees, X, y, 'OOBPrediction', 'on', 'Method', 'classification');
   
end