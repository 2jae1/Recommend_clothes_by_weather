[![한국어](https://img.shields.io/badge/lang-%ED%95%9C%EA%B5%AD%EC%96%B4-blue.svg)](README.md)
[![English](https://img.shields.io/badge/lang-English-red.svg)](README_en.md)

# 날씨 데이터를 반영한 맞춤 옷차림 추천 모델

![Alt text](/images/model_result.png)
<sub>맞춤 옷차림 추천 모델에 날씨 데이터를 입력했을 때 결과

우리의 모델은 사용자의 일정 기간 동안의 사진을 필요로 합니다.  
'연-월-일-사진을 찍은 지역명' 형태의 파일명을 필요로 하며, 데이터가 많을 수록 사용자에 관한 정보가 모델에 잘 반영됩니다.  
해당 사진과 연결되는 데이터가 날씨 데이터셋에 기록된 기간과 지역에 있어야 사용자의 정보가 반영됩니다.  
입력한 사진 데이터는 'ResNet-50' 모델을 Multi-label classification으로 전이 학습한 모델에 입력됩니다.  
사진 데이터의 파일명에서 연결된 날씨 데이터와, 모델의 결과인 옷 label은 학습 데이터로써 Random-Forest 모델에 적용됩니다.  
Random-Forest 모델은 학습을 통해, 입력받은 날씨 데이터에 사용자가 선호하는 옷 label을 출력하게 됩니다.  
이번 구현에서는 입력하는 이미지 데이터는 '상의', '하의', '드레스'가 들어간 이미지입니다.  
옷의 종류에 따라 각기 다른 Random-Forest 모델을 구현했으며 이미지 데이터가 부족하더라도, 날씨 데이터에 맞는 적절한 옷 label을 임의로 생성하여 모델의 학습에 사용하였습니다.    
사용자의 날씨 데이터 입력과 '상의, 하의'와 '드레스' 옵션을 선택하여 입력하면 학습에 사용된 옷 label 중 하나를 모델이 추천합니다. 

# Dataset
## Fashion Dataset

![Alt text](/images/information_of_fashion_data.png)

* 13개의 label로 이루어진 총 191,961개의 image data와
이미지의 정보가 저장된 json 파일이 있는
DeepFashion2 dataset을 활용하였습니다.

## Weather Dataset


![Alt text](/images/information_of_weather_data.png)

* 기상청 기상자료개방포털의 종관기상관측(ASOS) 자료에서 기온, 강수량, 풍속, 습도, 전운량  data를 추출하였습니다.
* 2014.07.23. 부터  2024.07.23. 까지
최근 10년간 전국 105개 지점에서 관측된 일별 기상 정보입니다.

# Model 구현에 사용된 MATLAB ToolBox
* [Deep Learning Toolbox](https://kr.mathworks.com/help/deeplearning/getting-started-with-deep-learning-toolbox.html)
* [Deep Learning Toolbox Model for ResNet-50 Network](https://kr.mathworks.com/matlabcentral/fileexchange/64626-deep-learning-toolbox-model-for-resnet-50-network)
* [Statistics and Machine Learning Toolbox](https://kr.mathworks.com/products/statistics.html)

# 주요 코드 설명

### **code/predict_clothes.m**
*  날씨를 입력하면 옷을 추천하는 함수 (최종 실행 코드)

### **model/Clothes_Classificatoin/clothes_predict_model.m** 
* Random Forest model 학습 코드

* line 2의 'photo_dir' 변수에는 사용자의 옷 사진 데이터가 들어있는 directory의 경로가 입력되어야 합니다.

* line 3의 'weather_dataset_dir' 변수에는 날씨 데이터셋이 들어있는 directory의 경로가 입력되어야 합니다.

### **model/Multilabel_Image_Classification/Multilabel_Image_Classification.m**
* Multilabel Classification model 학습 코드 

* line 12의 'labelLocationTrain'에는 DeepFashion2 train dataset의 json 파일을 COCO dataset format으로 변환 후 필요한 데이터만 저장한 mat 파일의 경로가 입력되었습니다.

* line 14의 'imageLocationTrain'에는 DeepFashion2 train dataset의 이미지가 저장된 폴더의 경로가 입력되었습니다.

* line 19의 'labelLocationVal'에는 DeepFashion2 validation dataset의 json 파일을 COCO dataset format으로 변환 후 필요한 데이터만 저장한 mat 파일의 경로가 입력되었습니다.
 
* line 21의 'imageLocationVal'에는 DeepFashion2 validation dataset의 이미지가 저장된 폴더의 경로가 입력되었습니다.

# 모델 사용 순서

## 데이터셋 준비
1. data/clothes_data 폴더에 옷 이미지 Multi-label classifcation을 위한 데이터셋을 준비합니다. 
2. data/personal_clothes_data 폴더에 사용자의 이미지를 저장합니다. 이미지 파일명은 '(사진을 찍은 연도)-(사진을 찍은 달)-(사진을 찍은 일)-(사진을 찍은 지역명)'의 형태로 입력해야합니다.(ex : '2024-07-31-서울') 이때 날짜는 날씨 데이터셋에 저장된 데이터의 날짜 기간 안에 들어가야 하고, 지역도 날씨 데이터셋에 저장된 지역에 포함되어있어야 합니다.
 3. data/weather_dataset 폴더에는 날씨 데이터를 저장한 csv파일을 저장합니다.

 ## Multi-label classifcation 모델 구현
 * model/Multilabel_Image_Classification/Multilabel_Image_Classification.m 파일을 실행합니다.

 ## Random-Forest 모델 구현
 * model/Clothes_Classificatoin/clothes_predict_model.m 파일을 실행합니다

## 학습된 모델의 결과 확인
* code/predict_clothes.m 함수를 이용하여 실행합니다.
* code 폴더로 Path 설정 후 command window에 predict_clothes() 입력 뒤, 원하는 옵션(상의, 하의 / 드레스)과 날씨 데이터 정보를 입력합니다.

# MATLAB AI challenge 2024 : Team TPO
[![Static Badge](https://img.shields.io/badge/Jeong--Soooo-yellow?style=flat-square&logo=Github)
](https://github.com/Jeong-Soooo)
[![Static Badge](https://img.shields.io/badge/2jae1-blue?style=flat-square&logo=Github)
](https://github.com/2jae1)
[![Static Badge](https://img.shields.io/badge/fluideun-green?style=flat-square&logo=Github)](https://github.com/fluideun)

# 관련링크
[![Static Badge](https://img.shields.io/badge/YouTube-FF0000?style=for-the-badge&logo=youtube&logoColor=white)](https://www.youtube.com/watch?v=tHFKcDdlyKk)

[![Static Badge](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://kr.mathworks.com/matlabcentral/fileexchange/170611-recommend-clothes-by-weather)

# 참조

##### [`[1]`]() : [Github : A-Z-Deepfashion2-Impleamentation](https://github.com/Manishsinghrajput98/A-Z-Deepfashion2-Impleamentation/blob/master/deepfashion2coco.py)

##### [`[2]`]() : [MathWorks : Multilabel Image Classification Using Deep Learning](https://kr.mathworks.com/help/deeplearning/ug/multilabel-image-classification-using-deep-learning.html)

##### [`[3]`]() : [MathWorks : Statistics and Machine Learning Toolbox, TrebbBagger](https://kr.mathworks.com/help/stats/treebagger.html)

# 데이터셋 참조

##### [`[1]`]() : [Github : DeepFashion2 , Yuying Ge and Ruimao Zhang and Lingyun Wu and Xiaogang Wang and Xiaoou Tang and Ping Luo, A Versatile Benchmark for Detection, Pose Estimation, Segmentation and Re-Identification of Clothing Images, CVPR, 2019](https://github.com/switchablenorms/DeepFashion2?tab=readme-ov-file)

##### [`[2]`]() : [기상청 기상자료개방포털 : 종관기상관측(ASOS)](https://data.kma.go.kr/data/grnd/selectAsosRltmList.do?pgmNo=36)
