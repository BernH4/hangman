require_relative 'game.rb'

class GameHandler
  def self.save
    File.open('savegame.yaml', 'w') do |file|
      file.puts YAML.dump(@game_instance)
    end
    puts 'Saved successfully!'
    exit
  end

  def self.load
    File.open('savegame.yaml') do |file|
      @game_instance = YAML.load(file)
    end
    puts "Load was successfull! You have #{10 - @game_instance.total_fails} tries left!"
    @game_instance.play
  end

  def self.start
    puts 'Do you want to start a new game or load an existing one? ( new / load )'
    loop do
      case gets.chomp.downcase
      when 'new'
        @game_instance = Game.new
        @game_instance.play
      when 'load'
        load
      else
        puts "Invalid input ( 'new' or 'load' )"
      end
    end
  end
end

GameHandler.start
