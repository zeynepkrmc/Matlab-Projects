%This fiveDay.m file contains lat, lon, and api key for
%fetchfiveDayForecast function.
lat = '38.9637';
lon = '35.2433';
cityName = {};
api_key = '0de2ef6646e30c5a61a344c227981893';  
weather_data = fetchFiveDayForecast(cityName, api_key);
disp('Processed weather data:');
disp(weather_data);
