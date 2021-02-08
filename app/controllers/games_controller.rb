class GamesController < ApplicationController


    def new
      @letters = Array.new(12) { ('A'..'Z').to_a.sample }
    end
    def score
      @input = params[:input]
      @grid = params[:grid]
      if included?
        if english_word?
          @score = "Congratulations! #{@input} is a valid English word"
        else
          @score = "Sorry but #{@input} does not seem to be a valid English word..."
        end
      else 
        @score = "Sorry but #{@input} can't be built out of #{@grid}"
      end
    end


    private

    def included?
      @input.chars.all? { |letter| @input.count(letter) <= @grid.count(letter) }
    end
    def english_word?
      response = open("https://wagon-dictionary.herokuapp.com/#{@input}")
      json = JSON.parse(response.read)
      return json['found']
    end

    
  end

