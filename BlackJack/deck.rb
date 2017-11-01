require_relative "./cards.rb"

class Deck
  CARD_DECK = %w(2+ 2<3 2^ 2<> 3+ 3<3 3^ 3<>
                 4+ 4<3 4^ 4<> 5+ 5<3 5^ 5<>
                 6+ 6<3 6^ 6<> 7+ 7<3 7^ 7<>
                 8+ 8<3 8^ 8<> 9+ 9<3 9^ 9<>
                 10+ 10<3 10^ 10<> J+ J<3 J^ J<>
                 Q+ Q<3 Q^ Q<> K+ K<3 K^ K<>
                 A+ A<3 A^ A<>)

  def initialize
    @deck = shuffle_deck
  end

  def shuffle_deck
    deck = CARD_DECK.map { |card| card = Cards.new(card) }
    deck.shuffle.reverse.shuffle
  end

  def initial_deal
    @deck.shift(2)
  end

  def add_card
    @deck.shift
  end
end