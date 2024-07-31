# RandomForest 모델에 사용되는 코드
아래의 코드는 clothes_predict_model.m 코드 구현을 위해 정의한 함수 파일입니다.
* * *
### clothes_predict_model.m
* Random-Forest model을 학습하여 파일로 저장하는 코드 
* 실행 결과로 날씨 데이터를 입력했을 때 'top', 'bottom', 'dress'를 추천하는 모델을 각각 저장
* * *
### top_model.mat, bottom_model.mat, dress_model.mat
* 상의, 하의, 드레스를 날씨에 따라 예측할 수 있는 모델이 저장된 파일 
* * *
### clothes_classification.m
* 각 사진에 있는 옷 label를 예측하는 함수
* * *
### connect_weather_information_my_photo.m
* 날씨 데이터와 옷 label를 연결하여 dataset을 반환하는 함수 (사용자의 이미지 데이터 사용)
* * *
### connect_weather_information_photo.m
* 날씨 데이터와 옷 label를 연결하여 dataset을 반환하는 함수 
* * *
### devide_clothes_dataset.m
* dataset을 상의, 하의, 드레스 각각의 dataset으로 분할하는 함수
* * *
### make_dataset.m
* 옷 label에 따른 날씨 데이터를 연결하여 새로운 dataset으로 저장하는 함수
* * *
### make_RF.m
* Random-Forest model을 구현, 학습하는 함수
* * *
### make_RF_for_check_accuracy.m
* Random-Forest model을 구현, 학습하여 모델의 성능을 평가할 수 있는 함수
