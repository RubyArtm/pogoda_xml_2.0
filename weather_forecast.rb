class WeatherForecast

  MOON_PHASE = { "New Moon" => "Новолуние",
                 "Waxing Crescent" => "Растущий полумесяц",
                 "First Quarter" => "Первый квартал",
                 "Waxing Gibbous" => "Растущая луна",
                 "Full Moon" => "Полная луна",
                 "Waning Gibbous" => "Убывающая Луна",
                 "Last Quarter" => "Последняя четверть",
                 "Waning Crescent" => "Убывающий полумесяц" }.freeze

  def initialize(hash_params)
    @name = hash_params[:name]
    @date = hash_params[:date]
    @temp = hash_params[:temp]
    @temp_min = hash_params[:temp_min]
    @temp_max = hash_params[:temp_max]
    @wind = hash_params[:wind]
    @humidity = hash_params[:humidity]
    @moon_phase = hash_params[:moon_phase]
    @uv_index = hash_params[:uv_index]
  end

  def self.location(node)
    new(
      name: node.elements["name"].text
    )
  end

  def self.current(node)
    new(
      date: node.elements["last_updated"].text,
      temp: node.elements["temp_c"].text,
      wind: node.elements["wind_kph"].text,
      humidity: node.elements["humidity"].text,
      uv_index: node.elements["uv"].text
    )
  end

  def self.forecast(node)

    new(
      date: node.elements["date"].text,
      temp_min: node.elements["day/mintemp_c"].text,
      temp_max: node.elements["day/maxtemp_c"].text,
      wind: node.elements["day/maxwind_kph"].text,
      humidity: node.elements["day/avghumidity"].text,
      moon_phase: MOON_PHASE[node.elements["astro/moon_phase"].text],
      uv_index: node.elements["day/uv"].text
    )
  end

  def to_s
    result = []
    result << "Город: #{@name}" if @name
    result << "\nДата: #{@date}" if @date
    result << "Температура: #{@temp}°C" if @temp
    result << "Мин. температура: #{@temp_min}°C" if @temp_min
    result << "Макс. температура: #{@temp_max}°C" if @temp_max
    result << "Ветер: #{@wind} км/ч" if @wind
    result << "Влажность: #{@humidity}%" if @humidity
    result << "Фаза луны: #{@moon_phase}" if @moon_phase
    result << "УФ индекс: #{@uv_index}" if @uv_index
    result.join("\n")
  end

end