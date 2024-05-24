function weather_data = fetchFiveDayForecast(cityName, api_key)  %lat, lon,
    %Input validation
    %if nargin < 3
     %   error('Input arguments ar. Please provide lat, lon, and api_key.');
    %end

    %I am ensuring that lat, lon, and api_key are strings
    %lat = strtrim(lat);
    %lon = strtrim(lon);

    %Containing degree symbol °C
    %lat = regexprep(lat, '[^0-9.-]', '');
    %lon = regexprep(lon, '[^0-9.-]', '');

    %API URL oluşturma
    %main_url = 'http://api.openweathermap.org/data/2.5/forecast';
    %complete_url = sprintf('%s?lat=%s&lon=%s&appid=%s&units=metric', main_url, lat, lon, api_key);
    %complete_url = ['http://api.openweathermap.org/data/2.5/forecast?lat=', lat, '&lon=', lon, '&appid=', '0de2ef6646e30c5a61a344c227981893', '&units=metric'];
    complete_url = ['http://api.openweathermap.org/data/2.5/forecast?q=', cityName, '&appid=', '0de2ef6646e30c5a61a344c227981893', '&units=metric'];

    %API çağrısı yapma
    options = weboptions('ContentType', 'json');
    try
        response = webread(complete_url, options);
    catch ex
        error('Failed to fetch data from OpenWeatherMap API: %s', ex.message);
    end
      %Check the structure of the response
    disp('API response structure:');
    disp(response);
    
    %Validate response structure
    if ~isfield(response, 'list')
        error('Unexpected API response structure. "list" field is missing.');
    end
    %Gelen verileri işleme
    weather_data = response;
    
    %İlgili bilgileri çıkartma (sıcaklık, nem, rüzgar hızı)
    num_entries = length(weather_data.list);
    temperature = zeros(1, num_entries);
    humidity = zeros(1, num_entries);
    wind_speed = zeros(1, num_entries);
    timestamps = datetime(zeros(1, num_entries), 'ConvertFrom', 'posixtime');

    for i = 1:num_entries
        temperature(i) = weather_data.list(i).main.temp;
        humidity(i) = weather_data.list(i).main.humidity;
        wind_speed(i) = weather_data.list(i).wind.speed;
        timestamps(i) = datetime(weather_data.list(i).dt, 'ConvertFrom', 'posixtime');
    end
    
    %Verileri döndürme
    weather_data = struct('temperature', temperature, 'humidity', humidity, 'wind_speed', wind_speed, 'timestamps', timestamps);
end