function exchange_rate_converter()
    % API anahtarınızı ve temel URL'yi tanımlayın
    api_key = '0de2ef6646e30c5a61a344c227981893';
    api_url = ['https://home.openweathermap.org/api_keys' + api_key];

    % Döviz kodlarını ve miktarı girdi olarak alın
    currency_one = input('Birinci döviz kodunu girin (örneğin: USD): ', 's');
    currency_two = input('İkinci döviz kodunu girin (örneğin: EUR): ', 's');
    amount = input('Miktarı girin: ');

    % Negatif miktar kontrolü
    if amount < 0
        disp('Miktar pozitif bir değer olmalıdır.');
        return;
    end

    % Döviz kodlarını çekmek için API'yi çağırma
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

    % Döviz kurlarını çekmek için API'yi çağırma
    conversion_url = [api_url, '/latest/', currency_one];
    try
        data = webread(conversion_url);
        conversion_rate = data.conversion_rates.(currency_two);
        
        % Hesaplama ve sonucu gösterme
        result = amount * conversion_rate;
        fprintf('%f %s = %f %s\n', amount, currency_one, result, currency_two);
    catch
        disp('Döviz kuru verisi alınırken bir hata oluştu.');
    end
end
