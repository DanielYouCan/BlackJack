require_relative './game'

class UserInterface
  attr_accessor :game

  def start_game
    puts "What's your name?"
    player_name = gets.chomp
    @game = Game.new(player_name)
    game_on
  end

  def game_on
    @game.hand_preset
    puts "Your cards: #{@game.player.hand.cards} points: #{@game.player.hand.points}"
    puts "Dealer's cards **"
    game_center
  end

  def game_center
    loop do
      options
      turn = gets.chomp
      @game.new_round(turn)
      if @game.player.hand.card_added? && !@game.round_over && @game.dealer.hand.cards_not_shown?
        puts "Your cards: #{@game.player.hand.cards} points: #{@game.player.hand.points}"
      end
      puts 'Dealer skipped a move' if !@game.dealer.hand.card_added? && !@game.round_over && @game.dealer.hand.cards_not_shown?
      puts 'Dealer took a card' if @game.dealer.hand.card_added? && !@game.round_over
      winner if is_over?
      break if is_over?
    end
    new_game if @game.game_over
    game_on
  end

  def is_over?
    @game.round_over || (@game.dealer.hand.hand_full? && @game.player.hand.hand_full?)
  end

  def winner
    if @game.winner.instance_of?(Player)
      puts "#{@game.player.name} wins! Money left:#{@game.player.bankroll}"
    elsif @game.winner.instance_of?(Dealer)
      puts "Dealer wins! Money left:#{@game.player.bankroll}"
    elsif @game.winner == :draw
      puts "It's a draw!"
    end
  end

  def new_game
    puts 'Do you want to play again? Yes/No'
    answer = gets.chomp
    if answer == 'Yes'
      @game.game_preset
      game_on
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
