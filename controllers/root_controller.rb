class RootController < ApplicationController
  get('/') do
    render(:erb, :index)
  end

  post('/') do
    input_array = format_input(params[:text])
    check_dictionary
  end

  def format_input(text)
    text.gsub(/[?.,:;'"!&()]/, "").split(" ")
  end

  def check_dictionary
    dict = []
    File.open('./public/images/dictionary.txt').each do |row|
      dict.push(row.strip.downcase)
    end
    dict
  end

end
