# frozen_string_literal: true

require_relative 'lib/hangman'
require 'json'

# Check if a saved game exists
if File.exist?('save.json')
  puts 'Press "A" to load the saved game or "N" to start a new game'
  answer = gets.chomp.upcase

  load_game = answer == 'A'
else
  load_game = false
end

if load_game
  game = JSON.parse(File.read('save.json'))
  word = game['word']
  wrong_guess = game['wrong_guess']
  word_reveal = game['word_reveal']
else
  # Load vocabulary
  words = File.readlines('words.txt')

  # Select a random word between 5 and 12 characters
  word = ''
  word = words[rand(words.length)] until word.length >= 5 && word.length <= 12

  wrong_guess = 0 # Store the number of wrong guesses made by user

  word_reveal = ['_'] * (word.length - 1)
end

hangman = Hangman.new

puts word

max_guesses = 12
loop do
  hangman.display(wrong_guess, max_guesses) # Display the hangman
  break if wrong_guess == max_guesses # Break out of loop if player has used all guesses

  puts word_reveal.join(' ') # Display the blanks
  puts 'Enter a letter to make a guess or press "1" to save the current game'

  guess = gets.chomp.downcase # Obtain case insensitive user guess

  # Save the game state
  if guess == '1'
    current_game = {
      word: word,
      wrong_guess: wrong_guess,
      word_reveal: word_reveal
    }

    File.write('save.json', JSON.generate(current_game))
    break
  end

  if word.include?(guess)
    word_reveal = hangman.update_word_reveal(word, guess, word_reveal)
    # Check win
    unless word_reveal.include?('_')
      puts 'You win!!!!'
      File.delete('save.json') if File.exist?('save.json') # Remove the saved game
      break
    end
  else
    wrong_guess += 1
  end
end
