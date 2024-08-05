[![한국어](https://img.shields.io/badge/lang-%ED%95%9C%EA%B5%AD%EC%96%B4-blue.svg)](README.md)
[![English](https://img.shields.io/badge/lang-English-red.svg)](README_en.md)

# Code used for multi-label classification model
The code below is the function file defined to implement the Multilabel_Image_Classification.m code.
* * *
### Multilabel_Image_Classification.m
*Code to learn a multi-label classification model and save it as a file.   
* When the user's image is input as an execution result, a model that outputs the clothes in the image is learned and saved.
* * *
### trainedNet.onnx
* A file containing a model that can predict clothes in a photo.  
* * *
### COCOImageID.m
* Function to find images belonging to a specific subset of categories in COCO dataset.  
* * *
### CustomBinaryCrossEntropyLossLayer.m
* Used for Multi-label Image Classification problems.  
* * *
### F1Score.m
* Function to calculate F1 Score.  
* * *
### jaccardIndex.m
* Function to calculate jaccard index.  
* * *
### performanceMetrics.m
* Function to calculate precision and recall.  
* * *
### prepareData_deepfashion.m
* Function to preprocess the dataset.  