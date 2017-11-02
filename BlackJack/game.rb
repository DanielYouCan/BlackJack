require_relative './player'
require_relative './dealer'
require_relative './hand'

class Game
  attr_accessor :player, :dealer, :deck, :round_over

  def initialize(player_name)
    @dealer = Dealer.new
    @bank = 0
    @player = Player.new(player_name)
  end

  def hand_settings
    @round_over = false
    @player.new_hand
    @dealer.new_hand
    @bank = 0
    @player.bankroll -= 10
    @dealer.bankroll -= 10
    @bank += 20
  end

  def round_results
    if draw?
      @dealer.bankroll += @bank / 2
      @player.bankroll += @bank / 2
      puts "That's a draw! Money left: #{@player.bankroll}"
    elsif dealer_wins?
      @dealer.bankroll += @bank
      puts "You've lost this round! Money left: #{@player.bankroll}"
    elsif player_wins?
      @player.bankroll += @bank
      puts "You've won! Money left: #{@player.bankroll}"
    end
  end

  def draw?
    @dealer.hand.points == @player.hand.points ||
      @player.hand.points > 21 && @dealer.hand.points > 21
  end

  def player_wins?
    @dealer.hand.points < @player.hand.points && @player.hand.points < 22 ||
      @dealer.hand.points > @player.hand.points && @dealer.hand.points > 21
  end

  def dealer_wins?
    @dealer.hand.points > @player.hand.points && @dealer.hand.points < 22 ||
      @dealer.hand.points < @player.hand.points && @player.hand.points > 21
  end
end
