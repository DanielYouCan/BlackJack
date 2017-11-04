require_relative './cards.rb'

class Deck
  def initialize
    @deck = shuffle_deck
  end

  def shuffle_deck
    deck = []
    Cards::SUITS.each do |suit|
      Cards::CARDS.each { |rank| deck << Cards.new(rank, suit) }
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
