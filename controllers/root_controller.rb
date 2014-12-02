class RootController < ApplicationController

  get('/') do
    render(:erb, :index)
  end

  post('/') do
    results = check_dictionary(params[:text])
    total_words = results[1] + results[2]
    accuracy  = ((results[1] / total_words.to_f) * 100).round(2)
    phrase = results[0]
    { phrase: phrase,
      accuracy: accuracy,
      incorrect: results[2],
      correct: results[1],
      total: total_words
    }.to_json
  end

  def load_dictionary
    dictionary = Hash.new { |hash, key| hash[key] = [] }
    File.open('public/images/dictionary.txt').each do |row|
      word = row.encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '').strip.gsub(/\/[^\s]+/, "").downcase
      first_letter =  word[0,1]
      dictionary[first_letter] << word
    end
    dictionary
  end

  def check_dictionary(text)
    dictionary = load_dictionary
    phrase = ""
    correct = 0
    incorrect = 0
    text.split(" ").each do |word|
      adjusted_word = word.gsub(/[?.,:;"!&()‟”“’‛‘'*-]/, "").downcase
      substituted_word = word.gsub(/[’‛]/, "'").downcase
      if (dictionary[adjusted_word[0]].include? adjusted_word) || (dictionary[adjusted_word[0]].include? substituted_word) || (adjusted_word.count("0-9") > 0)
        phrase += "#{word} "
        correct += 1
      elsif  adjusted_word == ""
        phrase += "#{word} "
      else
        phrase += "<span class='wrong'>#{word}</span> "
        incorrect += 1
      end
    end
    [phrase, correct, incorrect]
  end

end
