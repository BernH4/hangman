class Game
  attr_reader :secret_word, :hidden_word, :total_fails
  def initialize
    @dictionary = File.open('wordlist.txt', 'r')
    @secret_word = get_secret_word
    @hidden_word = Array.new(@secret_word.length, '_')
    @total_fails = 0
  end

  def get_secret_word
    secret_word = 'string'
    dic_arr = @dictionary.readlines
    loop do
      secret_word = dic_arr.sample.chomp.downcase
      break if (5..12).include?(secret_word.length)
    end
    @dictionary.close
    puts 'Random word has been choosen!'
    secret_word
  end

  def update_arr(usr_letter)
    @secret_word.each_char.with_index do |sec_letter, idx|
      @hidden_word[idx] = @secret_word[idx] if usr_letter == sec_letter
    end
  end

  def play
    loop do
      puts @hidden_word.join(' ')
      input = gets.chomp.downcase
      if input == 'save'
        GameHandler.save
        break
      else
        if @secret_word.include?(input)
          update_arr(input)
        else
          @total_fails += 1
          if @total_fails == 10
            puts "Sorry out of tries, the word was: #{@secret_word} !"
            exit
          else puts "Letter doesn`t seem to be included in the secret word! #{10 - @total_fails} tries left!"
          end
        end
        next if @hidden_word.include?('_')

        puts @hidden_word.join(' ')
        puts 'You guessed the word! Nice'
        exit
      end
    end
  end
end
