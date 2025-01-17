[![한국어](https://img.shields.io/badge/lang-%ED%95%9C%EA%B5%AD%EC%96%B4-blue.svg)](README.md)
[![English](https://img.shields.io/badge/lang-English-red.svg)](README_en.md)

## Dataset 구성 방법
data 폴더 안에는 총 3개의 폴더가 필요합니다.

## 1번째 폴더
'clothes_data'라는 폴더가 필요하며, ResNet50 전이학습 모델을 위한 데이터셋이 저장되는 폴더입니다.  
이 폴더 안에는 train data와 validation data가 들어가야 하며, 각 데이터셋의 모든 데이터 정보를 담고 있는 .mat 형식의 파일이 필요합니다.

## 2번째 폴더
'personal_clothes_data'라는 폴더가 필요하며, Random-Forest model 학습을 위한 데이터셋이 저장되는 폴더입니다.  
이 폴더 안에는 '(사진을 찍은 연도)-(사진을 찍은 월)-(사진을 찍은 일)-(사진을 찍은 지역명)' 형태의 파일명을 가진 이미지 파일이 저장되어야 합니다.

## 3번째 폴더
'weather_dataset'라는 폴더가 필요하며, Random-Forest model 학습을 위한 데이터셋이 저장되는 폴더입니다.  
이 폴더 안에는 날씨 데이터에 관한 데이터셋이 들어가야합니다.  
사진을 찍은 날짜와 지역에 매칭될 수 있는 데이터를 가져야하며, 현재 weather_dataset 폴더에 올려진 형태의 .csv파일이 필요합니다.
