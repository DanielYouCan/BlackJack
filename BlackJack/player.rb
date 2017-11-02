require_relative './hand'

class Player
  attr_accessor :bankroll, :cards, :points, :card_added
  attr_reader :name, :hand
  
  def initialize(name)
    @name = name
    @bankroll = 100
    @hand = Hand.new
  end

  def new_hand
    @hand = Hand.new
  end
end
