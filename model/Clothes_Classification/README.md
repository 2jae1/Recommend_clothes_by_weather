#### clothes_predict_model.m
** Random Forest model을 학습하여 파일로 저장하는 코드 

#### top_model.mat, bottom_model.mat, dress_model.mat
상의, 하의, 드레스를 날씨에 따라 예측할 수 있는 모델이 저장된 파일 

#### clothes_classification.m
각 사진에 있는 옷 종류를 예측하는 함수

#### connect_weather_information_my_photo.m
날씨 데이터와 옷 종류를 연결하여 dataset을 반환하는 함수 (개인 이미지 데이터 사용)

#### connect_weather_information_photo.m
날씨 데이터와 옷 종류를 연결하여 dataset을 반환하는 함수 

#### devide_clothes_dataset.m
dataset을 상의, 하의, 드레스 dataset로 분할하는 함수

#### make_dataset.m
옷 종류에 따른 날씨 데이터를 연결하여 dataset을 저장하는 함수

#### make_RF.m
Random Forest 구현, 학습하는 함수

#### make_RF_for_check_accuracy.m
Random Forest 구현, 학습하여 정확도 계산하는 함수