# frozen_string_literal: true

# Controls the hangman
class Hangman
  def display(fails, max_guesses)
    puts fails >= max_guesses ? 'You lost' : "You have #{fails} wrong guesses"
  end
end
