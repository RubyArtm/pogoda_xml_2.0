require 'uri'
require 'net/http'
require 'rexml/document'
require 'date'
require_relative 'weather_forecast'

puts "Прогноз погоды на ближайшие дни v 2.0"
puts "Информация с сайта weatherapi.com"
puts "Введите название города латинскими буквами"

choice = STDIN.gets.chomp

URL = "http://api.weatherapi.com/v1/forecast.xml?key=6ab11bd1284040b4aa4102444253007&q=" + choice + "&days=3&aqi=no&alerts=no"
uri = URI.parse(URL)

response = Net::HTTP.get_response(uri)
doc = REXML::Document.new(response.body)

location = doc.root.elements['location']
current = doc.root.elements['current']
forecast = doc.root.elements['forecast']

puts WeatherForecast.location(location)
puts WeatherForecast.current(current)

forecast.elements.each('forecastday') do |day|
  puts WeatherForecast.forecast(day)
end