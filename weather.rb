require "http"

system "clear"
puts "Welcome to the Weather App!"
puts "Enter a city:"

city = gets.chomp

response = HTTP.get("http://api.openweathermap.org/data/2.5/weather?q=#{city}&units=imperial&APPID=YOURAPIKEY")

weather_data = response.parse

# pp weather_data

temperature = weather_data["main"]["temp"]
description = weather_data["weather"][0]["description"]
city = weather_data["name"]

puts "Today in #{city} it is #{temperature} degrees outside with #{description}."