# 2024-MATLAB-AI-contest
It is a repository for MATLAB College Student AI Competition.

#### code/predict_clothes.m
날씨를 입력하면 옷을 추천하는 함수 (최종 실행 코드)

#### model/Clothes_Classificatoin/clothes_predict_model.m 
Random Forest model 학습 코드

line 2 photo_dir : 개인별 사진 directory

line 3 weather_dataset_dir : 날씨 데이터 directory

#### model/Multilabel_Image_Classification/Multilabel_Image_Classification.m 
Multilabel Classification model 학습 코드 

line 12 labelLocationTrain dir : DeepFashion2 train dataset의 json 파일을 COCO dataset format으로 변환 후 필요한 데이터만 저장한 mat 파일

line 13 imageLocationTrain : DeepFashion2 train dataset의 이미지

line 19 labelLocationVal dir : DeepFashion2 validation dataset의 json 파일을 COCO dataset format으로 변환 후 필요한 데이터만 저장한 mat 파일
 
line 21 imageLocationVal : DeepFashion2 validation dataset의 이미지