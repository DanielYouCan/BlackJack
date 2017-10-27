class Dealer
  attr_accessor :bankroll, :cards, :points, :card_added

  def initialize
    @name = "Dealer"
    @bankroll = 100
    @cards = []
    @points ||= 0
    @card_added = false
  end

  def card_added?
    @card_added
  end
end
