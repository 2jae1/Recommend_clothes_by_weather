[![한국어](https://img.shields.io/badge/lang-%ED%95%9C%EA%B5%AD%EC%96%B4-blue.svg)](README_ko.md)
[![English](https://img.shields.io/badge/lang-English-red.svg)](README_en.md)

# Customized clothing recommendation model that analyzes weather data

![Alt text](/images/model_result.png)
<sub>Results when weather data is input into a custom clothing recommendation model

Our model requires photos of users over a certain period of time.  
A file name in the form of 'Year-Month-Day-Name of the area where the photo was taken' is required, and the more data there is, the better the information about the user is reflected in the model.  
The data associated with the photo must be from the time period and region recorded in the weather dataset to reflect your information.  
The input photo data is input to a model that transfer-learned the 'ResNet-50' model through multi-label classification.  
The weather data linked from the file name of the photo data and the clothing label that is the result of the model are applied to the Random-Forest model as learning data.  
Through learning, the Random-Forest model outputs the user's preferred clothing label to the input weather data.  
In this implementation, the input image data is an image containing ‘top’, ‘bottoms’, and ‘dress’.  
Different Random-Forest models were implemented depending on the type of clothing, and even though there was a lack of image data, appropriate clothing labels that matched the weather data were randomly generated and used to train the model.    
When the user enters weather data and selects the 'top, bottom' and 'dress' options, the model recommends one of the clothing labels used for learning. 

# Dataset
## Fashion Dataset

![Alt text](/images/information_of_fashion_data.png)

* We used the DeepFashion2 dataset, which has a total of 191,961 image data consisting of 13 labels and a json file containing image information.

## Weather Dataset


![Alt text](/images/information_of_weather_data.png)

* Temperature, precipitation, wind speed, humidity, and total cloud cover data were extracted from the Synoptic Meteorological Observation (ASOS) data of the Korea Meteorological Administration's Meteorological Data Open Portal.
* This is daily weather information observed at 105 locations across the country over the past 10 years from 2014.07.23 to 2024.07.23.

# MATLAB ToolBox used to implement the model
* [Deep Learning Toolbox](https://kr.mathworks.com/help/deeplearning/getting-started-with-deep-learning-toolbox.html)
* [Deep Learning Toolbox Model for ResNet-50 Network](https://kr.mathworks.com/matlabcentral/fileexchange/64626-deep-learning-toolbox-model-for-resnet-50-network)
* [Statistics and Machine Learning Toolbox](https://kr.mathworks.com/products/statistics.html)

# Main code description

### **code/predict_clothes.m**
*  A function that recommends clothes when you enter the weather (final executable code)  

### **model/Clothes_Classificatoin/clothes_predict_model.m** 
* Random Forest model training code

* The path to the directory containing the user's clothing photo data must be entered in the 'photo_dir' variable in line 2.

* The path to the directory containing the weather dataset must be entered in the 'weather_dataset_dir' variable in line 3.  

### **model/Multilabel_Image_Classification/Multilabel_Image_Classification.m**
* Multilabel Classification model training code  

* In 'labelLocationTrain' in line 12, the path to the mat file that saved only the necessary data after converting the json file of the DeepFashion2 train dataset to COCO dataset format was entered.  

* In 'imageLocationTrain' in line 14, the path to the folder where the images of the DeepFashion2 train dataset are stored was entered.  

* In 'labelLocationVal' in line 19, the path to the mat file that saved only the necessary data after converting the json file of the DeepFashion2 validation dataset to COCO dataset format was entered.
 
* In 'imageLocationVal' in line 21, the path to the folder where the images of the DeepFashion2 validation dataset are stored was entered.

# Model usage order

## Dataset preparation
1. Prepare a dataset for clothes image multi-label classifcation in the data/clothes_data folder.  
2. Save your image in the data/personal_clothes_data folder. The image file name must be entered in the following format: '(Year when the photo was taken) - (Month when the photo was taken) - (Day when the photo was taken) - (Name of the region where the photo was taken)'. (ex: '2024-07-31- Seoul') At this time, the date must fall within the date period of the data saved in the weather dataset, and the region must also be included in the area saved in the weather dataset.  
 3. The csv file containing weather data is saved in the data/weather_dataset folder.  

 ## Multi-label classifcation model implementation
 * Run the model/Multilabel_Image_Classification/Multilabel_Image_Classification.m file.

 ## Random-Forest model implementation
 * Run the model/Clothes_Classificatoin/clothes_predict_model.m file.  

## Check the results of the learned model
* Execute using the code/predict_clothes.m function.
* After setting the path to the code folder, enter predict_clothes() in the command window, then enter the desired options (top, bottom / dress) and weather data information.

# MATLAB AI challenge 2024 : Team TPO
[![Static Badge](https://img.shields.io/badge/Jeong--Soooo-yellow?style=flat-square&logo=Github)
](https://github.com/Jeong-Soooo)
[![Static Badge](https://img.shields.io/badge/2jae1-blue?style=flat-square&logo=Github)
](https://github.com/2jae1)
[![Static Badge](https://img.shields.io/badge/fluideun-green?style=flat-square&logo=Github)](https://github.com/fluideun)

# Related Links
[![Static Badge](https://img.shields.io/badge/YouTube-FF0000?style=for-the-badge&logo=youtube&logoColor=white)](https://www.youtube.com/watch?v=tHFKcDdlyKk)

[![Static Badge](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://kr.mathworks.com/matlabcentral/fileexchange/170611-recommend-clothes-by-weather)

# Reference

##### [`[1]`]() : [Github : A-Z-Deepfashion2-Impleamentation](https://github.com/Manishsinghrajput98/A-Z-Deepfashion2-Impleamentation/blob/master/deepfashion2coco.py)

##### [`[2]`]() : [MathWorks : Multilabel Image Classification Using Deep Learning](https://kr.mathworks.com/help/deeplearning/ug/multilabel-image-classification-using-deep-learning.html)

##### [`[3]`]() : [MathWorks : Statistics and Machine Learning Toolbox, TrebbBagger](https://kr.mathworks.com/help/stats/treebagger.html)

# Dataset reference

##### [`[1]`]() : [Github : DeepFashion2 , Yuying Ge and Ruimao Zhang and Lingyun Wu and Xiaogang Wang and Xiaoou Tang and Ping Luo, A Versatile Benchmark for Detection, Pose Estimation, Segmentation and Re-Identification of Clothing Images, CVPR, 2019](https://github.com/switchablenorms/DeepFashion2?tab=readme-ov-file)

##### [`[2]`]() : [Meteorological Administration Open Meteorological Data Portal : Synoptic Meteorological Observation (ASOS)](https://data.kma.go.kr/data/grnd/selectAsosRltmList.do?pgmNo=36)
