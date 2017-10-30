require_relative './acerule'

class Hand
  include AceRule

  attr_reader :desc
  attr_accessor :cards_shown

  CARD_DESC = %w(2+ 2<3 2^ 2<> 3+ 3<3 3^ 3<>
                 4+ 4<3 4^ 4<> 5+ 5<3 5^ 5<>
                 6+ 6<3 6^ 6<> 7+ 7<3 7^ 7<>
                 8+ 8<3 8^ 8<> 9+ 9<3 9^ 9<>
                 10+ 10<3 10^ 10<> J+ J<3 J^ J<>
                 Q+ Q<3 Q^ Q<> K+ K<3 K^ K<>
                 A+ A<3 A^ A<>)

  VALUES = { '2+' => 2, '2<3' => 2, '2^' => 2, '2<>' => 2,
             '3+' => 3, '3<3' => 3, '3^' => 3, '3<>' => 3,
             '4+' => 4, '4<3' => 4, '4^' => 4, '4<>' => 4,
             '5+' => 5, '5<3' => 5, '5^' => 5, '5<>' => 5,
             '6+' => 6, '6<3' => 6, '6^' => 6, '6<>' => 6,
             '7+' => 7, '7<3' => 7, '7^' => 7, '7<>' => 7,
             '8+' => 8, '8<3' => 8, '8^' => 8, '8<>' => 8,
             '9+' => 9, '9<3' => 9, '9^' => 9, '9<>' => 9,
             '10+' => 10, '10<3' => 10, '10^' => 10, '10<>' => 10,
             'J+' => 10, 'J<3' => 10, 'J^' => 10, 'J<>' => 10,
             'Q+' => 10, 'Q<3' => 10, 'Q^' => 10, 'Q<>' => 10,
             'K+' => 10, 'K<3' => 10, 'K^' => 10, 'K<>' => 10,
             'A+' => 11, 'A<3' => 11, 'A^' => 11, 'A<>' => 11 }

  def initialize
    @desc = CARD_DESC.shuffle.reverse.shuffle
    @card_shown = false
  end

  def cards_shown?
    @cards_shown
  end

  def cards_not_shown?
    !@cards_shown
  end

  def deal_cards(player)
    player.cards = @desc.shift(2)
  end

  def skip_move
    puts "Move is passed to another player"
  end

  def add_card(player, dealer)
    player.card_added = true
    player.cards << @desc.shift
    count_final_points(player)
    open_cards(player, dealer) if player.cards.size == 3 && dealer.cards.size == 3
    puts "Your cards: #{player.cards} points: #{player.points}" if player.name != 'Dealer' && cards_not_shown?
  end

  def open_cards(player, dealer)
    @cards_shown = true
    puts "dealer's cards: #{dealer.cards} points: #{dealer.points}"
    puts "Your cards: #{player.cards} points: #{player.points}"
  end

  def count_points(player)
    player.cards.each { |card| player.points += VALUES[card] }
    player.points
    check_ace(player)
  end

  def count_final_points(player)
    player.points += VALUES[player.cards[2]]
    check_ace(player)
  end
end