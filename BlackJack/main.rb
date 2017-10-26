require_relative './player'
require_relative './dealer'

class Game
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
    puts "Choose what you'd like to do:
    0 - skip a move
    1 - add a card
    2 - open cards"
  end

  def skip_move
  end

  def add_card
  end

  def open_cards
  end

  def read(move)
    case move
    when "0"

    when "1"

    when "2"

    when "finish"
      abort "stop_program"
    end
  end
end
