require 'pry'

class Game
  attr_reader :secret_word, :hidden_word
  def initialize
    @dictionary = File.open('wordlist.txt', 'r').readlines
    @secret_word = get_secret_word
    @hidden_word = Array.new(@secret_word.length, '_')
  end

  def get_secret_word
    secret_word = 'string'
    loop do
      secret_word = @dictionary.sample.chomp
      break if (5..12).include?(secret_word.length)
    end
    secret_word
  end

  def check_letter(usr_letter)
    @secret_word.each_char.with_index do |sec_letter, idx|
      @hidden_word[idx] = @secret_word[idx] if usr_letter == sec_letter
    end
  end

  # TODO
  # win / loose message (no loose of attempts if letter is correct!)
  def play
    puts 'Random word has been choosen!'
    10.times do
      puts @hidden_word.join(' ')
      puts 'Enter a letter:'
      check_letter(gets.chomp)
    end
  end
end

game1 = Game.new

p game1.secret_word
game1.play
