function dataset = connect_weather_information_my_photo(photo_dataset,weather_dataset_dir)
    if isempty(photo_dataset)
        dataset = [];
        return;
    end
    
    % Input directory of weather database
    weather_path = fullfile(weather_dataset_dir);
    database = readtable(weather_path, 'VariableNamingRule', 'preserve');
    
    % Preprocessing datetime data
    database{:,'일시'} = datetime(database{:,'일시'}, 'InputFormat', 'yyyy-MM-dd');
    
    % Dataset to insert weather information
    dataset = [];
    numRows = size(photo_dataset, 1);
    
    for i = 1: numRows
        file_name =  photo_dataset(i,1);
        info = string(split(file_name, '-'));
        pre_date = info(1) + '-' + info(2) + '-' + info(3);
        date = datetime(pre_date, 'InputFormat', 'yyyy-MM-dd');
        pre_region = split(info(4), '.');
        region = pre_region(1);
        data = database(database{:,'일시'} == date & database{:,'지점명'} == region,:);
        label_1 = repmat(photo_dataset(i, 2), height(data), 1);
        label_2 = repmat(photo_dataset(i, 3), height(data), 1);
        data = addvars(data, label_1, label_2, 'NewVariableNames',{'label1', 'label2'});
        dataset = [dataset; data];
    end
    
    % Enter only the need data 
    cols_to_remove = {'지점','지점명','일시'};
    dataset = removevars(dataset, cols_to_remove);
    
    % Preprocessing NaN data
    labelColumn = dataset(:, end-1:end);
    dataset = fillmissing(dataset(:,1:end-2), 'constant', 0);
    dataset = [dataset, labelColumn];
    dataset = table2cell(dataset);
end

