function dataset = make_dataset(weather_dataset_dir)
    weather_path = fullfile(weather_dataset_dir);
    database = readtable(weather_path, 'VariableNamingRule', 'preserve');
    region_data = database{:, 2};
    region_data = unique(region_data);
    region_data = num2cell(region_data);
    region_size = numel(region_data);
    
    label = {"short_sleeved_shirt" "long_sleeved_shirt" ...
        "short_sleeved_outwear" "long_sleeved_outwear" "vest" "sling" ...
        "shorts" "trousers" "skirt" "short_sleeved_dress" ...
        "long_sleeved_dress" "vest_dress" "sling_dress"};
    
    top = ["short_sleeved_shirt" "long_sleeved_shirt" ...
        "short_sleeved_outwear" "long_sleeved_outwear" "vest" "sling"];
    bottom = ["shorts" "trousers" "skirt"];
    dress = ["short_sleeved_dress" "long_sleeved_dress" "vest_dress" "sling_dress"];
    
    
    Num_category = 20;
    
    labels = repmat(label, 1, Num_category);
    labels = labels(:);
    dataset = table(labels, 'VariableNames', {'label'});
    
    numRows = size(dataset, 1);
    new_column_data = repmat("", numRows, 1);
    dataset.kind = new_column_data;
    dataset.date = new_column_data;
    
    for i = 1:numRows
        label_str = string(dataset{i, 'label'});
    
        % Second column
        if ismember(label_str,top)
            dataset{i,'kind'} = {'top'};
        elseif ismember(label_str,bottom)
            dataset{i,'kind'} = {'bottom'};
        elseif ismember(label_str,dress)
            dataset{i,'kind'} = {'dress'};
        end
    
        % Third column
        random_year = randi([2015, 2023]);
        switch label_str
            case {'sling', 'vest', 'sling_dress', 'vest_dress'}
                month_range = [7, 8];
                days_in_month = [31, 31];
            case {'short_sleeved_shirt', 'shorts', 'skirt'}
                month_range = [5, 6, 7, 8, 9];
                days_in_month = [31, 30, 31, 31, 30];
            case 'short_sleeved_outwear'
                month_range = [4, 5, 9];
                days_in_month = [30, 31, 30];
            case 'long_sleeved_shirt'
                month_range = [10, 11, 3];
                days_in_month = [30, 31, 31];
            case 'long_sleeved_outwear'
                month_range = [12, 1, 2];
                days_in_month = [31, 31, 28];
            case 'trousers'
                month_range = [9, 10, 11, 12, 1, 2, 3, 4, 5];
                days_in_month = [30, 31, 30, 31, 31, 28, 31, 30, 31];
            case 'short_sleeved_dress'
                month_range = [4, 5, 6, 7, 8];
                days_in_month = [30, 31, 30, 31, 31];
            case 'long_sleeved_dress'
                month_range = [9, 10, 11, 12, 1, 2, 3];
                days_in_month = [30, 31, 30, 31, 31, 28, 31];
        end
        random_index = randi(region_size);
        region = region_data{random_index};
    
        random_month_idx = randi(length(month_range)); % 월 범위의 인덱스
        random_month = month_range(random_month_idx);
        max_days = days_in_month(random_month_idx);
        random_day = randi(max_days);
        random_date = datetime(random_year, random_month, random_day, 'Format', 'yyyy-MM-dd');
        date = datestr(random_date, 'yyyy-mm-dd');
        image_name = strcat(date, '-', region, '.jpg');
        dataset{i, 'date'} = {image_name};
    
        dataset = dataset(:, {'date', 'kind', 'label'});
    end
end