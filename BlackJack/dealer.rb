require_relative './hand'

class Dealer
  attr_accessor :bankroll, :card_added
  attr_reader :name, :hand

  def initialize
    @name = 'Dealer'
    @bankroll = 100
    @hand = Hand.new
    @card_added = false
  end

  def card_added?
    @card_added
  end

  def dealer_move(deck, player)
    if (@hand.points >= 18 && @hand.cards_shown?)
      puts "Dealer's move:"
      @hand.skip_move
    elsif (@hand.points < 18) && @hand.cards_not_shown?
      puts 'Dealer took a card'
      @hand.take_card(deck)
      @hand.open_cards if @hand.hand_full? == 3 && player.hand.hand_full?
    end
  end
end
