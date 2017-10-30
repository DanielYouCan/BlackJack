require_relative './main'
require_relative './hand'

class Dealer
  attr_accessor :bankroll, :cards, :points, :card_added
  attr_reader :name

  def initialize
    @name = 'Dealer'
    @bankroll = 100
    @cards = []
    @points ||= 0
    @card_added = false
  end

  def card_added?
    @card_added
  end

  def dealer_move(player, hand)
    if (points >= 18 && hand.cards_shown?) || (points >= player.points && points < 22 && points > 15)
      puts "Dealer's move:"
      hand.skip_move
    elsif (points < 18) && (points <= player.points) && hand.cards_not_shown? && (player.points < 22)
      puts 'Dealer took a card'
      hand.add_card(self, player)
      hand.open_cards(player, self) if player.cards.size == 3 && cards.size == 3
    end
  end
end
