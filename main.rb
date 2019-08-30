require "string_colors.rb"
require "words_list.rb"
require "hangman.rb"


play_game = true
while play_game
  hangman = Hangman.new(words.sample)
  hangman.start_game
  play_game = hangman.replay_game?
end

