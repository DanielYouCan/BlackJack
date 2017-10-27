class Player
  attr_accessor :bankroll, :cards, :points, :card_added

  def initialize(name)
    @name = name
    @bankroll = 100
    @cards = []
    @points ||= 0
    @card_added = false
  end

  def card_added?
    @card_added
  end
end
