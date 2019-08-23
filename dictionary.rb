require "http"


while true
  system "clear"
  puts "Welcome to the dictionary app!"
  puts "What word would you like to explore?"

  input_word = gets.chomp

  response = HTTP.get("https://api.wordnik.com/v4/word.json/#{input_word}/definitions?limit=200&includeRelated=false&useCanonical=false&includeTags=false&api_key=ac6099e63826b8650f05e22c4cc08baa2f21668e3f16176fd").parse

  puts "Definitions:"
  response.each do |definition|
    puts "- #{definition['text']}"
  end
  puts

  response = HTTP.get("https://api.wordnik.com/v4/word.json/#{input_word}/topExample?useCanonical=false&api_key=ac6099e63826b8650f05e22c4cc08baa2f21668e3f16176fd").parse

  top_example = response["text"]

  puts "Top Example: #{top_example}"
  puts

  response = HTTP.get("https://api.wordnik.com/v4/word.json/#{input_word}/pronunciations?useCanonical=false&limit=50&api_key=ac6099e63826b8650f05e22c4cc08baa2f21668e3f16176fd").parse

  puts "Pronunciations:"
  response.each do |pronunciation| 
    puts "- #{pronunciation['raw']}"
  end

  response = HTTP.get("https://api.wordnik.com/v4/word.json/#{input_word}/audio?useCanonical=false&limit=50&api_key=b05bbefa71250039e60030a86260994d095206c2efdc555ad").parse

  audio_file = response[0]["fileUrl"]
  # alternate syntax to open file in browser from ruby (mac specific)
  system("open", audio_file)

  puts "Enter q to quit, press any other key to continue"
  input_option = gets.chomp
  if input_option == "q"
    puts "Thank you, come again!"
    break
  end
end
