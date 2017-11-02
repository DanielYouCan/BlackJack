require_relative './hand'

class Dealer
  attr_accessor :bankroll, :card_added
  attr_reader :name, :hand

  def initialize
    @name = 'Dealer'
    @bankroll = 100
    @hand = Hand.new
  end

  def new_hand
    @hand = Hand.new
  end

  def dealer_move(deck, player)
    puts "Dealer's move:"
    if @hand.points >= 18
      @hand.skip_move
    elsif @hand.points < 18 && @hand.cards_not_shown?
      puts 'Dealer took a card'
      @hand.take_card(deck)
      if @hand.hand_full? && player.hand.hand_full?
        puts "#{player.name}'s resuts: "
        player.hand.open_cards
        puts "Dealer's resuts: "
        @hand.open_cards
      end
    end
  end
end
