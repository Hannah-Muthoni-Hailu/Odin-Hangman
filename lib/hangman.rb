# frozen_string_literal: true

# Controls the hangman
class Hangman
  def display(fails, max_guesses)
    puts fails >= max_guesses ? 'You lost' : "You have #{fails} wrong guesses"
  end

  def update_word_reveal(word, guess, word_reveal)
    # Ensure that each instance of the guessed letter is accounted for
    inds = (0...word.length).find_all { |i| word[i, 1] == guess }
    inds.each do |ind|
      word_reveal[ind] = guess
    end

    word_reveal
  end
end
