# Multi-label classification 모델에 사용되는 코드
아래의 코드는 Multilabel_Image_Classification.m 코드 구현을 위해 정의한 함수 파일입니다.
* * *
### Multilabel_Image_Classification.m
* Multilabel Classification model을 학습하여 파일로 저장하는 코드 
* 실행 결과로 사용자의 이미지를 입력하면 이미지의 옷을 출력하는 모델을 학습하여 저장
* * *
### trainedNet.onnx
* 사진에 있는 옷을 예측할 수 있는 모델이 저장된 파일 
* * *
### COCOImageID.m
* COCO dataset에서 categories의 특정 부분 집합에 속하는 이미지를 찾는 함수
* * *
### CustomBinaryCrossEntropyLossLayer.m
* multi-label image classification 문제에 사용
* * *
### F1Score.m
* F1 Score를 계산하는 함수
* * *
### jaccardIndex.m
* jaccard index를 계산하는 함수
* * *
### performanceMetrics.m
* precision, recall를 계산하는 함수 
* * *
### prepareData_deepfashion.m
* 데이터셋을 전처리하는 함수 