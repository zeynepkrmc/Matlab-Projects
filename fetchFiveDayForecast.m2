function weather_data = fetchFiveDayForecast(cityName, api_key)  
    % &units=metric for celcius.
    myUrl = ['http://api.openweathermap.org/data/2.5/forecast?q=', cityName, '&appid=', '0de2ef6646e30c5a61a344c227981893', '&units=metric'];
    % new api key is  : 46ef4400c892663c963a16b6a70b6ab8, old api key is : 0de2ef6646e30c5a61a344c227981893
    % Making API call with try - catch block. I used webread for reading json
    % data.
    options = weboptions('ContentType', 'json');
    try
        response = webread(myUrl, options);
    catch ex
        error('Failed to fetch data from OpenWeatherMap API: %s', ex.message);
        
    end
    
    %Check the structure of the response.
    disp('API response structure:');
    disp(response);
    
    % I validate response structure.
    if ~isfield(response, 'list')
        error('API response structure is unexpected. "list" field is missing.');
    end
    
    % Processing incoming data
    weather_data = response;
    
    % Extracting temperature, humidity, wind speed information.
    num_entries = length(weather_data.list);
    temperature = zeros(1, num_entries);
    humidity = zeros(1, num_entries);
    wind_speed = zeros(1, num_entries);
    timestamps = datetime(zeros(1, num_entries), 'ConvertFrom', 'posixtime');

    for i = 1:num_entries
        temperature(i) = weather_data.list{i}.main.temp;
        humidity(i) = weather_data.list{i}.main.humidity;
        wind_speed(i) = weather_data.list{i}.wind.speed;
        timestamps(i) = datetime(weather_data.list{i}.dt, 'ConvertFrom', 'posixtime');
    end

    % I return data.
    weather_data = struct('temperature', temperature, 'humidity', humidity, 'wind_speed', wind_speed, 'timestamps', timestamps);
end
