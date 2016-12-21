class ComputerPlayer
  attr_reader :dictionary, :comp_secret_word, :candidate_words

  def self.comp_with_dictionary(file)
    ComputerPlayer.new(File.readlines(file).map(&:chomp))
  end

  def initialize(dictionary)
    @dictionary = dictionary
  end

  def pick_secret_word
    index = rand(0...dictionary.size)
    @comp_secret_word = dictionary[index]
    comp_secret_word.length
  end

  def register_secret_length(secret_length)
    @candidate_words = dictionary.select { |word| word.length == secret_length }
  end

  def guess(board)
    letters = candidate_words.join.chars.sort.reject { |c| board.include?(c) }
    groups = letters.chunk {|c| c}.map(&:last)
    most_common = groups.sort_by(&:length).last[0]
    guess = most_common

    puts "Guess: #{guess}"
    guess
  end

  def check_guess(letter)
    indicies = []
    comp_secret_word.chars.each_with_index do |e, i|
      indicies << i if e == letter
    end
    indicies
  end

  def handle_response(letter, indicies)

    indicies.each do |index|
      @candidate_words.reject! { |word| word[index] != letter }
      @candidate_words.reject! { |word| word.count(letter) > indicies.count}
    end

    @candidate_words.reject! { |w| w.include?(letter) } if indicies.empty?
  end

end
