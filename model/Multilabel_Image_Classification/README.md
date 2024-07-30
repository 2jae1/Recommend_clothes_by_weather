#### Multilabel_Image_Classification.m
** Multilabel Classification model을 학습하여 파일로 저장하는 코드 

#### trainedNet.onnx
사진에 있는 옷을 예측할 수 있는 모델이 저장된 파일 

#### COCOImageID.m
COCO dataset에서 categories의 특정 부분 집합에 속하는 이미지를 찾는 함수

#### CustomBinaryCrossEntropyLossLayer.m
multilabel image classification 문제에 사용

#### F1Score.m
F1Score 계산하는 함수

#### jaccardIndex.m
jaccard index 계산하는 함수

#### performanceMetrics.m
precision, recall 계산하는 함수 

#### prepareData_deepfashion.m
prepare data 함수 