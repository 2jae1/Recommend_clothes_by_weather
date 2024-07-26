function weather_info = connect_weather_information_photo(photo_dir,dataset)
    % Input directory of clothes
    dir_path = fullfile(photo_dir);
    clothes_list = dir(dir_path);
    clothes_list = clothes_list(~ismember({clothes_list.name}, {'.', '..'}));
    
    % Input directory of weather database
    weather_path = fullfile(dataset);
    database = readtable(weather_path, 'VariableNamingRule', 'preserve');
    
    % Preprocessing datetime data
    database{:,'일시'} = datetime(database{:,'일시'}, 'InputFormat', 'yyyy-MM-dd');
    
    weather_info = [];
    
    for k = 1: length(clothes_list)
        file_name = clothes_list(k).name;
        info = string(split(file_name, '-'));
        pre_date = info(1) + '-' + info(2) + '-' + info(3);
        date = datetime(pre_date, 'InputFormat', 'yyyy-MM-dd');
        pre_region = split(info(4), '.');
        region = pre_region(1);
        data = database(database{:,'일시'} == date & database{:,'지점명'} == region,:);
        weather_info = [weather_info; data];
    end
    
    % Enter only the need data 
    cols_to_remove = {'지점','지점명','일시'};
    weather_info = removevars(weather_info, cols_to_remove);
    
    % Preprocessing NaN data
    weather_info = fillmissing(weather_info, 'constant', 0);
end

