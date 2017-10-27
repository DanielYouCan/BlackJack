require_relative './player'
require_relative './dealer'
require_relative './acerule'

class Game
  include AceRule

  CARD_DESC = %w(2+ 2<3 2^ 2<> 3+ 3<3 3^ 3<>
         4+ 4<3 4^ 4<> 5+ 5<3 5^ 5<>
         6+ 6<3 6^ 6<> 7+ 7<3 7^ 7<>
         8+ 8<3 8^ 8<> 9+ 9<3 9^ 9<>
         10+ 10<3 10^ 10<> J+ J<3 J^ J<>
         Q+ Q<3 Q^ Q<> K+ K<3 K^ K<>
         A+ A<3 A^ A<>)

  VALUES = {"2+" => 2, "2<3" => 2, "2^" => 2, "2<>" => 2,
            "3+" => 3, "3<3" => 3, "3^" => 3, "3<>" => 3,
            "4+" => 4, "4<3" => 4, "4^" => 4, "4<>" => 4,
            "5+" => 5, "5<3" => 5, "5^" => 5, "5<>" => 5,
            "6+" => 6, "6<3" => 6, "6^" => 6, "6<>" => 6,
            "7+" => 7, "7<3" => 7, "7^" => 7, "7<>" => 7,
            "8+" => 8, "8<3" => 8, "8^" => 8, "8<>" => 8,
            "9+" => 9, "9<3" => 9, "9^" => 9, "9<>" => 9,
            "10+" => 10, "10<3" => 10, "10^" => 10, "10<>" => 10,
            "J+" => 10, "J<3" => 10, "J^" => 10, "J<>" => 10,
            "Q+" => 10, "Q<3" => 10, "Q^" => 10, "Q<>" => 10,
            "K+" => 10, "K<3" => 10, "K^" => 10, "K<>" => 10,
            "A+" => 11, "A<3" => 11, "A^" => 11, "A<>" => 11}

  def initialize
    @desc = CARD_DESC.shuffle.reverse.shuffle
    @dealer = Dealer.new
    @player
  end

  def start_game
    puts "What's your name?"
    player_name = gets.chomp
    player = Player.new(player_name)
    @player = player
    @player.bankroll -= 10
    @dealer.bankroll -= 10
    @player.cards = @desc.shift(2)
    @dealer.cards = @desc.shift(2)
    @player.points = VALUES[@player.cards[0]] + VALUES[@player.cards[1]]
    check_ace(@player)
    check_ace(@dealer)
    puts "#{player_name}'s cards: #{@player.cards} points: #{@player.points}"
    puts "Dealer's cards **"
    loop do
      options
      move = gets.chomp
      read(move)
    end
  end

  private

  def options
    if @card_added
      puts "Choose what you'd like to do:
      0 - skip a move
      2 - open cards"
    else
      puts "Choose what you'd like to do:
      0 - skip a move
      1 - add a card
      2 - open cards"
    end
  end

  def dealer_points
    @dealer.cards.each { |card| @dealer.points += VALUES[card] }
    @dealer.points
  end

  def skip_move
    puts "You've passed a move to another player"
  end

  def add_card
    @card_added = true
    @player.cards << @desc.shift
    @player.points += VALUES[@player.cards[2]]
    puts "Your cards: #{@player.cards} points: #{@player.points}"
  end

  def open_cards
    puts "dealer's cards: #{@dealer.cards} points: #{dealer_points}"
  end

  def read(move)
    case move
    when "0"
      skip_move
    when "1"
      add_card
    when "2"
      open_cards
    when "finish"
      abort "stop_program"
    end
  end
end
