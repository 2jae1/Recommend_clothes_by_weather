photo_dir = '../../data/personal_clothes_data';
weather_dataset_dir = '../../data/weather_dataset/weather_database_20140723_20240723.csv';

% Generate virtual data
generated_dataset = make_dataset(weather_dataset_dir);
generated_dataset = string(table2cell(generated_dataset));

generated_top_dataset = [];
generated_bottom_dataset = [];
generated_dress_dataset = [];

numRows = size(generated_dataset, 1);

% Devide each case
for i = 1:numRows
    if strcmp(generated_dataset{i,2}, 'top')
        generated_top_dataset = [generated_top_dataset; generated_dataset(i,[1,3])];
    elseif strcmp(generated_dataset{i,2}, 'bottom')
        generated_bottom_dataset = [generated_bottom_dataset; generated_dataset(i,[1,3])];
    elseif strcmp(generated_dataset{i,2}, 'dress')
        generated_dress_dataset = [generated_dress_dataset; generated_dataset(i,[1,3])];
    end
end

% Match dataset to weather data
top = connect_weather_information_photo(generated_top_dataset,weather_dataset_dir);
bottom = connect_weather_information_photo(generated_bottom_dataset,weather_dataset_dir);
dress = connect_weather_information_photo(generated_dress_dataset,weather_dataset_dir);

% Import user's data and match weatherdata
clothes_info = clothes_classification(photo_dir);
my_dataset = connect_weather_information_my_photo(clothes_info,weather_dataset_dir);
[my_top_dataset, my_bottom_dataset, my_dress_dataset] = devide_clothes_dataset(my_dataset);

top_dataset = [top; my_top_dataset];
bottom_dataset = [bottom; my_bottom_dataset];
dress_dataset = [dress; my_dress_dataset];

% Train both virtual datasets and user datasets
top_model = make_RF(top_dataset);
bottom_model = make_RF(bottom_dataset);
dress_model = make_RF(dress_dataset);

% Save model
save('top_model.mat','top_model');
save('bottom_model.mat','bottom_model');
save('dress_model.mat','dress_model');