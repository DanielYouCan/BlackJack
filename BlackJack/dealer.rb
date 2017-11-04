require_relative './hand'

class Dealer
  attr_accessor :bankroll
  attr_reader :name, :hand

  def initialize
    @name = 'Dealer'
    @bankroll = 100
    @hand = Hand.new
  end

  def new_hand
    @hand = Hand.new
  end

  def dealer_move(deck)
    if @hand.points >= 18
      @hand.skip_move
      @hand.card_added = false
    elsif @hand.points < 18 && @hand.cards_not_shown?
      @hand.card_added = true
      @hand.take_card(deck)
      puts 'Dealer took a card'
    end
  end
end
