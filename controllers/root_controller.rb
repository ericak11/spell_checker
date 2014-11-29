class RootController < ApplicationController
  get('/') do
    render(:erb, :index)
  end

  post('/') do
    results = check_dictionary(params[:text])
    total_words = results[1] + results[2]
    accuracy  = (results[1]/total_words.to_f) * 100
    phrase = results[0]
    {phrase: phrase, accuracy: accuracy, incorrect: results[2], correct: results[1], total: total_words}.to_json
  end

  def check_dictionary(text)
    phrase = ""
    correct = 0
    incorrect = 0
    dict = Hash.new{|hash, key| hash[key] = []}
    File.open('public/images/dictionary.txt').each do |row|
      word = row.strip.downcase
      first_letter =  word[0,1]
      dict[first_letter] << word
    end
    text.split(" ").each do |word|
      adjusted_word = word.gsub(/[?.,:;'"!&()]/, "").downcase
      if dict[adjusted_word[0]].include? adjusted_word
        phrase += "#{word} "
        correct += 1
      else
        phrase += "<span class='wrong'>#{word}</span> "
        incorrect += 1
      end
    end
    [phrase, correct, incorrect]
  end

end
