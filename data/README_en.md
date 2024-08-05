[![한국어](https://img.shields.io/badge/lang-%ED%95%9C%EA%B5%AD%EC%96%B4-blue.svg)](README.md)
[![English](https://img.shields.io/badge/lang-English-red.svg)](README_en.md)

## How to configure Dataset
A total of 3 folders are required within the data folder.

## 1st folder
A folder called 'clothes_data' is required, and this is the folder where the dataset for the ResNet50 transfer learning model is stored.  
This folder must contain training data and validation data, and a .mat format file containing all data information for each dataset is required.

## 2nd folder
A folder called 'personal_clothes_data' is required, and this is the folder where the dataset for learning the Random-Forest model is stored.  
In this folder, image files with file names in the format of ‘(Year when the photo was taken)-(Month when the photo was taken)-(Day when the photo was taken)-(Name of the region where the photo was taken)’ must be saved.

## 3rd folder
A folder called 'weather_dataset' is required, and this is the folder where the dataset for learning the Random-Forest model is stored.  
This folder should contain a dataset related to weather data.  
You must have data that can be matched to the date and region where the photo was taken, and a .csv file currently uploaded to the weather_dataset folder is required.
