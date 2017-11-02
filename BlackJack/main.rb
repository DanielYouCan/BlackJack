require_relative './game'

class UserInterface
  attr_accessor :game

  def start_game
    puts "What's your name?"
    player_name = gets.chomp
    @game = Game.new(player_name)
    @game.game_interface(self)
    @game.new_round
  end

  def new_game
    puts 'Do you want to play again? Yes/No'
    answer = gets.chomp
    if answer == 'Yes'
      @game.player.bankroll = 100
      @game.dealer.bankroll = 100
      start_game
    elsif answer == 'No'
      puts 'Game is over'
    end
  end

  def options
    if @game.player.hand.card_added?
      puts "Choose what you'd like to do:
      0 - skip a move
      2 - open cards
      finish - quit game"
    else
      puts "Choose what you'd like to do:
      0 - skip a move
      1 - add a card
      2 - open cards
      finish - quit game"
    end
  end
end

UserInterface.new.start_game
