require_relative 'ComputerPlayer'
require_relative 'HumanPlayer'

class Hangman
  MAX_GUESSES = 6
  attr_reader :guesser, :referee, :board, :guesses

  def initialize(players)
    @guesser = players[:guesser]
    @referee = players[:referee]
    @guesses = 0
  end

  def setup
    secret_word = referee.pick_secret_word
    guesser.register_secret_length(secret_word)
    @board = '_' * secret_word
  end

  def play
    setup

    until game_over?
      display
      take_turn

      if board.scan('_').count == 0
        puts "\n The man lives!"
        return
      end

    end
    puts "\n The mans been hung."
  end

  def take_turn
    letter = guesser.guess(board)
    indicies = referee.check_guess(letter)

    update_board(letter, indicies)
    @guesses += 1 if indicies.empty?

    guesser.handle_response(letter, indicies)
  end

  def update_board(letter, indicies)
    indicies.each { |index| @board[index] = letter }
  end

  def display
    puts "\n Secret word: #{board} \n\n"
  end

  def game_over?
    guesses == MAX_GUESSES
  end

end


if $PROGRAM_NAME == __FILE__
  player1 = ComputerPlayer.comp_with_dictionary("lib/dictionary.txt")
  player2 = HumanPlayer.new

  players = {referee: player2, guesser: player1}
  game = Hangman.new(players)
  game.play
end
