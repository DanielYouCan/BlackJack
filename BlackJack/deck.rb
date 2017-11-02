require_relative './cards.rb'

class Deck
  def initialize
    @deck = shuffle_deck
  end

  def shuffle_deck
    deck = []
    %w[<> <3 ^ +].each do |suit|
      (2..10).each { |rank| deck << Cards.new(rank, suit) }
      %w[J Q K A].each { |rank| deck << Cards.new(rank, suit) }
    end
    deck.shuffle.reverse.shuffle
  end

  def initial_deal
    @deck.shift(2)
  end

  def add_card
    @deck.shift
  end
end
