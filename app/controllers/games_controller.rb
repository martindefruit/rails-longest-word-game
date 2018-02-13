require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = Array.new(7) { ('A'..'Z').to_a.sample }
  end

  def score
    @answer = params[:user_answer].upcase
    @letters = params[:letters]
    if included?(@answer, @letters) && isEnglish?(@answer)
      @result = "good one"
    else
      @result = "No a match"
    end

  end

  def included?(answer, letters)
    answer.chars.all? { |letter| answer.count(letter) <= letters.count(letter) }
  end

  def isEnglish?(answer)
    response = open("https://wagon-dictionary.herokuapp.com/#{answer}")
    @json = JSON.parse(response.read)
    if @json["found"]
      return true
    end
  end

end
