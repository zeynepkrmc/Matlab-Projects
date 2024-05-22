function weather_data = fetchFiveDayForecast(lat, lon, api_key)
    % API URL'sini oluşturma
    base_url = 'http://api.openweathermap.org/data/2.5/forecast';
    complete_url = sprintf('%s?lat=%s&lon=%s&appid=%s&units=metric', base_url, lat, lon, api_key);
    
    % API çağrısı yapma
    options = weboptions('ContentType', 'json');
    try
        response = webread(complete_url, options);
    catch ex
        error('Failed to fetch data from OpenWeatherMap API: %s', ex.message);
    end
    
    % Gelen verileri işleme
    weather_data = response;
    
    % İlgili bilgileri çıkartma (sıcaklık, nem, rüzgar hızı)
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
    
    % Verileri döndürme
    weather_data = struct('temperature', temperature, 'humidity', humidity, 'wind_speed', wind_speed, 'timestamps', timestamps);
end
