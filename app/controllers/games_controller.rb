require "json"
require "open-uri"

class GamesController < ApplicationController
  def scores
    # If the word is not valid or is not in the grid, the score will be 0

    @score = 0
    letters_array = params[:letters_grid].split
    params[:word].each_char do |char|
      letters_array.each_with_index do |letter, index|
        if char == letter
          letters_array.detele_at(index)
        else
          # char not dysplayed on the grid
          @score = 0
        end
      end
    end

    #Check if it's a valid English word
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    dictionary_response = URI.open(url).read
    parsed_response = JSON.parse(dictionary_response)

    if parsed_response

puts "#{user["name"]} - #{user["bio"]}"

    if @score !=0
      @score_message = "Congratulations! #{params[:word]} is a English Word "
    else
      @score_message = "Sorry but #{params[:word]} can't be built out of #{@letter}"
    end
    raise
  end


  def new
    #display a new ransom grid and a form
    #the form will be submitted with POST to the score action
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }

  end

end
