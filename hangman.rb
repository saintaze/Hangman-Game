
class Hangman

  def initialize(word)
    @attempts_remaining = 5
    @attempted_chars = []
    @word = word
    @display_word = @word.dup
    @word_guess = Array.new(word.size, "_")
  end

  def create_line_breaks(num)
    num.times {puts}
  end

  def display_welcome_screen
    puts "------------------------------".brown
    puts "******** HANGMAN GAME ********".brown
    puts "------------------------------".brown
    puts 
    puts "----------- ".cyan + "RULES".cyan + " ------------".cyan
    puts
    puts "Try to find the secret word by".cyan
    puts "guessing one letter at a time.".cyan
    puts "Each correct guess will reveal".cyan
    puts "the letter in the word box.   ".cyan
    puts "You have 5 tries to guess the ".cyan
    puts "correct word. Best of Luck!".cyan
  end

  def get_user_input
    gets.chomp
  end

  def start_game
    create_line_breaks(3)
    display_welcome_screen
    create_line_breaks(3)
    self.play_game
  end

  def validate_input(char)
    until char =~ /[a-zA-Z]/ && char.length == 1
      print "Enter a valid letter: "
      char = get_user_input
    end
    char.downcase
  end

  def display_noreplay_message
    create_line_breaks(2)
    puts "Thanks for playing!".cyan
    puts "Sorry to see you go!".cyan  + " :(".brown
    create_line_breaks(2)
  end

  def display_replay_message
    create_line_breaks(1)
    puts "You are a daring person!".cyan + " :)".brown
    puts "Lets go again!".cyan
  end

  def replay_game?
    create_line_breaks(2)
    puts "Would you like to replay? (y/n)"
    char = get_user_input.downcase
    until char == "y" || char == "n"
      puts "Enter a valid option? (y/n)"
      char = get_user_input.downcase
    end
    if char == "n"
      display_noreplay_message
      false
    else
      display_replay_message
      true
    end
  end

  def display_loss_screen
    puts "You Lose! ".cyan + ":(".brown
    puts "Your remaining attempts are: " + @attempts_remaining.to_s.brown
    correct_guesses = @word_guess.all? {|char| char == '_'} ? "none" : @word_guess.join.brown
    puts "Your corrent guesses are: " + correct_guesses.brown
    puts "The correct word is: " + @display_word.brown
  end

  def display_win_screen
    puts "You Won! ".cyan + ":)".brown 
    puts "Your remaining attempts are: " + @attempts_remaining.to_s.brown 
    puts "You guessed the corrent word: "  + @display_word.brown
  end

  def display_game_stats
    puts "Incorrect guesess remaining: " + @attempts_remaining.to_s.brown
    print "Attempted chars: "; puts @attempted_chars.to_s.brown
    print "Word: "; puts @word_guess.to_s.brown
    print "Enter a letter: "
  end

  def update_game_stats(char)
    @attempted_chars << char
    word_index = @word.index(char)

    unless word_index.nil?
      @word[word_index] = "_"
      @word_guess[word_index] = char
    else
      @attempts_remaining -= 1
    end
  end

  def play_game
    until @word.chars.all? {|char| char == '_'} || @attempts_remaining == 0
      display_game_stats   
      char = self.validate_input(get_user_input)
      create_line_breaks(2)  
      update_game_stats(char)
      if @word.chars.all? {|char| char == '_'} 
        display_win_screen
      end
      if @attempts_remaining == 0
        display_loss_screen
      end
    end
  end
  
end
