require_relative './player'
require_relative './dealer'
require_relative './hand'

class Game
  attr_accessor :player, :dealer, :deck, :round_over
  attr_reader :winner, :game_over

  def initialize(player_name)
    @dealer = Dealer.new
    @bank = 0
    @player = Player.new(player_name)
  end

  def game_preset
    @game_over = false
    @player.bankroll = 100
    @dealer.bankroll = 100
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

  def hand_preset
    hand_settings
    @deck = Deck.new
    @player.hand.deal_cards(@deck)
    @dealer.hand.deal_cards(@deck)
  end

  def new_round(turn)
    move(turn)
    @dealer.dealer_move(@deck) if @player.hand.cards_not_shown?
    end_round if @dealer.hand.hand_full? && @player.hand.hand_full?
    round_results if @player.hand.cards_shown? && !@round_over
  end

  def end_round
    puts "#{@player.name} cards"
    @player.hand.open_cards
    puts "Dealer's cards"
    @dealer.hand.open_cards
    round_results
  end

  def move(turn)
    case turn
    when '0'
      @player.hand.skip_move
    when '1'
      if @player.hand.card_added?
        false
      else
        @player.hand.take_card(@deck)
      end
    when '2'
      end_round
    when 'finish'
      abort
    end

    @game_over = true if money_left?
  end

  def money_left?
    @player.bankroll.zero? || @dealer.bankroll.zero?
  end

  def round_results
    if draw?
      @dealer.bankroll += @bank / 2
      @player.bankroll += @bank / 2
      @winner = :draw
    elsif dealer_wins?
      @dealer.bankroll += @bank
      @winner = @dealer
    elsif player_wins?
      @player.bankroll += @bank
      @winner = @player
    end
    @round_over = true
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
