class HumanPlayer
attr_accessor :guessed

  def initialize
    @guessed = ""
  end

  def pick_secret_word
    puts "Pick a secret word and enter the length:"
    gets.chomp.to_i
  end

  def register_secret_length(secret_word)
    secret_word
  end

  def guess(board)
    puts "Guessed: #{guessed}"
    puts "Enter a letter:"
    gets.chomp
  end

  def check_guess(letter)
    puts "Enter the correct positions: (ex. 012)"
    indicies = gets.chomp.chars.map(&:to_i)
  end

  def handle_response(letter)
    @guessed << letter
  end

end
