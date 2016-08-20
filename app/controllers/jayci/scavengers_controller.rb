class Jayci::ScavengersController < ApplicationController
  def index
  end

  def show
    previous = Scavenger.find_by(id: params[:id].to_i - 1)
    @scavenger = Scavenger.find_by(id: params[:id])
    if previous && previous.correct
      if @scavenger.correct
        if @scavenger == Scavenger.last
          redirect_to "/jayci/scavenger/done"
        else
          redirect_to "/jayci/scavenger/#{@scavenger.id + 1}"
        end
      else
        render clues[@scavenger.clue]
      end
    else
      if @scavenger == Scavenger.where(correct: false).first
        render clues[@scavenger.clue]
      else
        redirect_to "/jayci/scavenger/#{previous.id}"
      end
    end
  end

  def update
    guess = params[:guess].split(' ').map(&:downcase)
    scavenger = nil
    guess.each do |g|
      scavenger = Scavenger.find_by("guesses LIKE ?", "%#{g}%")
      break if scavenger
    end
    if scavenger
      scavenger.update(correct: true)
      if scavenger == Scavenger.last
        redirect_to "/jayci/scavenger/done"
      else
        flash[:success] = 'You got it Jayci!'
        redirect_to "/jayci/scavenger/#{scavenger.id + 1}"
      end
    else
      @scavenger = Scavenger.find_by(id: params[:id])
      flash[:info] = "Not quite, Babe! Try again!"
      render clues[@scavenger.clue]
    end
  end

  def done
    answers = Scavenger.all.map(&:correct)
    if answers.include?(false)
      redirect_to "/jayci/scavenger/#{Scavenger.last.id}"
    else
      render 'done'
    end
  end

  def clues
    {
      "5-beekman" => "beekman",
      "sugar-house-prison" => "sugar",
      "mulberry-bend" => "mulberry",
      "41-cooper" => "cooper",
      "bellevue" => "bellevue",
      "green-acre-park" => "green",
      "berlin-wall" => "berlin",
      "cleopatra-needle" => "cleopatra",
      "st-john" => "st-john"
    }
  end
end
