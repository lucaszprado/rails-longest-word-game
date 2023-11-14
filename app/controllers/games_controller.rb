require "json"
require "open-uri"

class GamesController < ApplicationController
  def scores
    # If the word is not valid or is not in the grid, the score will be 0

    @score = 0
    not_displayed_on_grid = 0
    letters_array = params[:letters_grid].split
    params[:word].each_char do |char|
      letters_array.each_with_index do |letter, index|
        if char == letter
          letters_array.detele_at(index)
        else
          # char not dysplayed on the grid
          not_displayed_on_grid = 1
          @score_message = "Sorry but #{params[:word]} can't be built out of #{letters_array}"
        end
      end
    end

    #Check if it's a valid English word and displayed on Grid
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    dictionary_checker = flats = JSON.parse(URI.open(url).read)

    if dictionary_checker["found"] == false
      not_a_english_word = 1
      @score_message = "Sorry but #{params[:word]} does not seem to be a valid English word..."
    end


    # Building message to the user when correct answer
    if not_a_english_word == 0 && not_displayed_on_grid == 0
      @score = params[:word].length
      @score_message = "Congratulations! #{params[:word]} is a English Word "
    end


  end


  def new
    #display a new ransom grid and a form
    #the form will be submitted with POST to the score action
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }

  end

end
