%% INPUTS (all are strings/char)
api_key = '0de2ef6646e30c5a61a344c227981893';
api_url = ['https://home.openweathermap.org/api_keys' + api_key];
lat = '38.9637° ';
lon = '35.2433°';
supported_codes_url = [api_url, '/codes'];
try
        data = webread(supported_codes_url);
        items = data.supported_codes;
% Döviz kodlarını ve isimlerini görüntüleyin
        disp('Desteklenen döviz kodları:');
        for i = 1:length(items)
            fprintf('%s - %s\n', items{i}{1}, items{i}{2});
        end
    catch
        disp('Döviz kodları alınırken bir hata oluştu.');
        return;
    end

% fetch the data
%api_base = ['https://home.openweathermap.org/api_keys'+ api_key];
%data_out_struct = webread(...
 %   [ api_base '&api_key=' api_key '&lat=' lat '&lon=' lon]...
  %  ); % you'll get a struct out

 