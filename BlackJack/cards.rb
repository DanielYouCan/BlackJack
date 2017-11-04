class Cards
  attr_reader :value
  CARDS = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A'].freeze
  VALUES = { 'J' => 10, 'Q' => 10, 'K' => 10, 'A' => 11 }.freeze
  SUITS = %w[<> ^ <3 +].freeze

  def initialize(rank, suit)
    validate(rank, suit)
    @card = rank.to_s + suit
    @value = VALUES[rank] || rank
  end

  def validate(rank, suit)
    raise 'Invalid card type' unless SUITS.include?(suit) && CARDS.include?(rank)
  end
end
