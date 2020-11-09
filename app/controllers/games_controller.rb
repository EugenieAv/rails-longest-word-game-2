class GamesController < ApplicationController
  def new
    voyel = %w(A E I O U Y)
    cons = ('A'..'Z').to_a - voyel
    @letters = (voyel.sample(4)+cons.sample(4)).shuffle

  end

  def score
    @submit = params[:word].upcase
    @letters = params[:leslettres].split
    @in_grid = is_in_the_grid?(@submit, @letters)
    @english_word = is_english_word?(@submit)
  end

  private

  def is_in_the_grid?(word, grid)
    @submit.chars.all?{ |letter| word.count(letter) <= grid.count(letter)}
  end

  def is_english_word?(word)
    require 'json'
    require 'open-uri'

    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    JSON.parse(open(url).read)["found"]
  end
end
