function weather_data = fiveDay(lat, lon, start_time, end_time, api_key)
    % Validate input arguments
    if nargin < 5
        error('Not enough input arguments. You must provide latitude, longitude, start time, end time, and API key.');
    end

    % Construct the API URL
    api_key = '0de2ef6646e30c5a61a344c227981893';
    lat = '38.9637° ';
    lon = '35.2433°';
    start_time = 1609459200;        % Start time in Unix timestamp (e.g., 1st Jan 2021)
    end_time = 1609545600;          % End time in Unix timestamp (e.g., 2nd Jan 2021)
    base_url = 'https://history.openweathermap.org/data/2.5/history/city';
    complete_url = sprintf('%s?lat=%s&lon=%s&type=hour&start=%d&end=%d&appid=%s', ...
                           base_url, lat, lon, start_time, end_time, api_key);

    % Make the API request
    options = weboptions('ContentType', 'json');
    try
        response = webread(complete_url, options);
    catch ex
        error('Failed to fetch data from OpenWeatherMap API: %s', ex.message);
    end
    
    weather_data = response;  % The response is already in JSON format

    % Process the data as needed (e.g., extract temperature, humidity, etc.)
    % Customize this part based on your requirements

    % Example: Display the weather data (for debugging purposes)
    disp('Historical weather data:');
    disp(weather_data);
end
api_key = '0de2ef6646e30c5a61a344c227981893';
lat = '38.9637° ';
lon = '35.2433°';
start_time = 1609459200;        % Start time in Unix timestamp (e.g., 1st Jan 2021)
end_time = 1609545600;          % End time in Unix timestamp (e.g., 2nd Jan 2021)

    % Call the function and get the weather data
weather_data = fiveDay(lat, lon, start_time, end_time, api_key);

% Optionally, process or display the weather data further
disp('Processed weather data:');
disp(weather_data);