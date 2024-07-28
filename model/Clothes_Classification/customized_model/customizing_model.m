photo_dir = '../../../data/personal_clothes_data';
weather_dataset_dir = '../../../data/weather_dataset/weather_database_20140723_20240723.csv';

model_files = {'top_model.mat', 'bottom_model.mat', 'dress_model.mat'};
model_names = {'top_model', 'bottom_model', 'dress_model'};
model_vars = {'top_model', 'bottom_model', 'dress_model'};

for i = 1:length(model_files)
    model_path = fullfile('../initializing_model', model_files{i});
    loadData = load(model_path);
    assignin('base', model_vars{i}, loadData.(model_names{i}));
end

clothes_info = clothes_classification(photo_dir);
dataset = connect_weather_information_photo(clothes_info,weather_dataset_dir);

[top_dataset, bottom_dataset, dress_dataset] = devide_clothes_dataset(dataset);
customized_top_model = make_customized_model(top_dataset, top_model,'top');
customized_bottom_model = make_customized_model(bottom_dataset, bottom_model,'bottom');
customized_dress_model = make_customized_model(dress_dataset, dress_model,'dress');

save('top_model.mat','customized_top_model');
save('bottom_model.mat','customized_bottom_model');
save('dress_model.mat','customized_dress_model');

