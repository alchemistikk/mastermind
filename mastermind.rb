class DecodingBoard
  attr_accessor :board

  def initialize
    @board = Array.new(12) { Array.new(4) }
  end

  def show_board
    @board.each { |row| p row }
  end

  def guess_text(num)
    "Enter Guess ##{num + 1}:"
  end

  def guess_four_times(guess)
    4.times do |num|
      puts guess_text(num)
      guess[num] = validate_guess_input(gets.chomp)
    end
  end

  def validate_guess_input(guess)
    while guess != 'a' &&
          guess != 'b' &&
          guess != 'c' &&
          guess != 'd' &&
          guess != 'e' &&
          guess != 'f'
      puts 'Must input a letter between "a" and "f".'
      guess = gets.chomp
    end
    guess
  end
end

class HintBoard
  attr_accessor :hint_board

  def initialize
    @hint_board = Array.new(12) { [] }
  end

  def show_board
    @hint_board.each { |row| p row }
  end

  def check_guess_vs_code(guess, code, hint_board_row)
    guess.each_with_index do |v, i|
      if v == code[i]
        hint_board_row.push('B')
      elsif code.include?(v)
        hint_board_row.push('W')
      end
    end
  end
end

class Code
  attr_accessor :code

  def initialize
    @letters = %w[a b c d e f]
    @code = []
  end

  def generate_code
    4.times do
      @code.push(@letters.sample)
    end
  end

  def validate_codemaster(codemaster)
    while codemaster != 'c' && codemaster != 'h'
      puts 'Enter either "c" or "h".'
      codemaster = gets.chomp
    end
  end

  def choose_codemaster(code)
    puts 'Codemaster: "h" for human or "c" for computer.'
    codemaster = gets.chomp
    code.validate_codemaster(codemaster)
    case codemaster
    when 'c'
      code.generate_code
    when 'h'
      code.enter_code
    end
  end

  def enter_code
    4.times do |i|
      puts 'Enter code letter.'
      code[i] = gets.chomp
    end
  end
end

def guess_loop(decoding_board, hint_board, code)
  decoding_board.board.each_with_index do |_v, i|
    guess = []
    decoding_board.guess_four_times(guess)
    decoding_board.board[i] = guess
    decoding_board.show_board
    puts
    hint_board.check_guess_vs_code(guess, code, hint_board.hint_board[i])
    hint_board.show_board
    if guess == code
      puts 'Game Over. Codebreaker wins.'
      break
    end
    puts
  end
end

def play_game
  code = Code.new
  code.choose_codemaster(code)
  decoding_board = DecodingBoard.new
  hint_board = HintBoard.new
  guess_loop(decoding_board, hint_board, code.code)
end

play_game
