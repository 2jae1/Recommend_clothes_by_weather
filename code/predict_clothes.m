clear;clc;
photo_dir = '../data/personal_clothes_data';
weather_dataset_dir = '../data/weather_dataset/weather_database_20140723_20240723.csv';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pre_dataset = clothes_classification(photo_dir);
[top_dataset, bottom_dataset, dress_dataset] = classify_clothes_dataset(photo_dir);
top = connect_weather_information_photo(top_dataset,weather_dataset_dir);
bottom = connect_weather_information_photo(bottom_dataset,weather_dataset_dir);
dress = connect_weather_information_photo(dress_dataset,weather_dataset_dir);