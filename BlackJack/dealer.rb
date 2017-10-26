class Dealer
  attr_accessor :bankroll, :cards, :points

  def initialize
    @name = "Dealer"
    @bankroll = 100
    @cards = []
    @points ||= 0
  end
end
