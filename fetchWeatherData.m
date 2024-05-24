function weatherData = fetchWeatherData(cityName, apiKey)
    % API URL'sini oluştur
    apiUrl = sprintf('https://api.openweathermap.org/data/2.5/weather?q=%s&appid=%s&units=metric', cityName, '0de2ef6646e30c5a61a344c227981893');

    % Web'den veriyi çek
    response = webread(apiUrl);

    % Elde edilen veriyi işle
    weatherData.temperature = response.main.temp;
    weatherData.humidity = response.main.humidity;
    weatherData.windSpeed = response.wind.speed;
end
