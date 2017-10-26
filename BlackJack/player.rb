class Player
  attr_accessor :bankroll, :cards, :points

  def initialize(name)
    @name = name
    @bankroll = 100
    @cards = []
    @points ||= 0
  end
end
