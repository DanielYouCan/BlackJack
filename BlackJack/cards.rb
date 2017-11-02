class Cards
  attr_reader :value

  VALUES = { 'J' => 10, 'Q' => 10, 'K' => 10, 'A' => 11 }.freeze

  def initialize(rank, suit)
    @card = rank.to_s + suit
    @value = VALUES[rank] || rank
  end
end
