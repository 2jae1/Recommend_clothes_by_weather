[![한국어](https://img.shields.io/badge/lang-%ED%95%9C%EA%B5%AD%EC%96%B4-blue.svg)](README.md)
[![English](https://img.shields.io/badge/lang-English-red.svg)](README_en.md)

# Code used for RandomForest model
The code below is the function file defined to implement the clothes_predict_model.m code.
* * *
### clothes_predict_model.m
* Code to learn Random-Forest model and save it as a file.  
* When weather data is entered as an execution result, models that recommend 'top', 'bottom', and 'dress' are saved respectively.  
* * *
### top_model.mat, bottom_model.mat, dress_model.mat
* A file containing a model that can predict tops, bottoms, and dresses according to the weather.
* * *
### clothes_classification.m
* A function that predicts the clothing label in each photo.
* * *
### connect_weather_information_my_photo.m
* A function that returns a dataset by connecting weather data and clothing labels. (using the user's image data)
* * *
### connect_weather_information_photo.m
* A function that returns a dataset by connecting weather data and clothing labels.  
* * *
### devide_clothes_dataset.m
* Function to split the dataset into datasets for each top, bottom, and dress.
* * *
### make_dataset.m
* A function that connects weather data according to clothing labels and saves it as a new dataset.
* * *
### make_RF.m
* Function to implement and learn the Random-Forest model.
* * *
### make_RF_for_check_accuracy.m
* A function that can evaluate the performance of the model by implementing and learning the Random-Forest model.
