# frozen_string_literal: true

require_relative 'lib/hangman'

# Load vocabulary
words = File.readlines('words.txt')

# Select a random word between 5 and 12 characters
word = ''
word = words[rand(words.length)] until word.length >= 5 && word.length <= 12

wrong_guess = 0 # Store the number of wrong guesses made by user

word_reveal = ['_'] * (word.length - 1)
hangman = Hangman.new

puts word

def start_game(wrong_guess, word_reveal, hangman, word)
  loop do
    hangman.display(wrong_guess, word.length) # Display the hangman
    puts word_reveal.join(' ') # Display the blanks

    guess = gets.chomp.downcase # Obtain case insensitive user guess

    if word.include?(guess)
      word_reveal = update_word_reveal(word, guess, word_reveal)
      break unless word_reveal.include?('_')
    else
      wrong_guess += 1
    end
  end
end

def update_word_reveal(word, guess, word_reveal)
  # Ensure that each instance of the guessed letter is accounted for
  inds = (0...word.length).find_all { |i| word[i, 1] == guess }
  inds.each do |ind|
    word_reveal[ind] = guess
  end

  word_reveal
end

start_game(wrong_guess, word_reveal, hangman, word)
