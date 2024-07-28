weather_dataset_dir = '../../../data/weather_dataset/weather_database_20140723_20240723.csv';
dataset = make_dataset(weather_dataset_dir);
dataset = string(table2cell(dataset));

top_dataset = [];
bottom_dataset = [];
dress_dataset = [];

numRows = size(dataset, 1);

for i = 1:numRows
    if strcmp(dataset{i,2}, 'top')
        top_dataset = [top_dataset; dataset(i,[1,3])];
    elseif strcmp(dataset{i,2}, 'bottom')
        bottom_dataset = [bottom_dataset; dataset(i,[1,3])];
    elseif strcmp(dataset{i,2}, 'dress')
        dress_dataset = [dress_dataset; dataset(i,[1,3])];
    end
end

top = connect_weather_information_photo(top_dataset,weather_dataset_dir);
bottom = connect_weather_information_photo(bottom_dataset,weather_dataset_dir);
dress = connect_weather_information_photo(dress_dataset,weather_dataset_dir);

top_model = make_ANN(top);
bottom_model = make_ANN(bottom);
dress_model = make_ANN(dress);

save('top_model.mat','top_model');
save('bottom_model.mat','bottom_model');
save('dress_model.mat','dress_model');
