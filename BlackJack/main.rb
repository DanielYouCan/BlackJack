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
    @bank ||= 0
  end

  def start_game
    puts "What's your name?"
    player_name = gets.chomp
    player = Player.new(player_name)
    @player = player
    @player.bankroll -= 10
    @dealer.bankroll -= 10
    @bank += 20
    @player.cards = @desc.shift(2)
    @dealer.cards = @desc.shift(2)
    count_points(@player)
    count_points(@dealer)
    check_ace(@dealer)
    puts "#{player_name}'s cards: #{@player.cards} points: #{@player.points}"
    puts "Dealer's cards **"
    while @player.bankroll > 0 && @dealer.bankroll > 0 do
      options
      move = gets.chomp
      read(move)
      dealer_move
    end
  end

  private

  def options
    if @player.card_added?
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

  def dealer_move
    puts "Dealer's move:"
    if @dealer.points >= 18
      skip_move
    elsif @dealer.points < 18 && (@dealer.points < @player.points)
      puts "Dealer took a card"
      add_card(@dealer)
    end
  end

  def count_points(player)
    player.cards.each { |card| player.points += VALUES[card] }
    player.points
    check_ace(player)
  end

  def skip_move
    puts "Move is passed to another player"
  end

  def add_card(player)
    player.card_added = true
    player.cards << @desc.shift
    player.points += VALUES[player.cards[2]]
    check_ace(player)

    puts "Your cards: #{player.cards} points: #{player.points}" if player == @player
  end

  def open_cards
    puts "dealer's cards: #{@dealer.cards} points: #{@dealer.points}"
    if @dealer.points > @player.points && @dealer.points < 22
      @dealer.bankroll += @bank
      @bank = 0
      puts "You've lost this round"
    elsif @dealer.points == @player.points
      @dealer.bankroll += @bank/2
      @player.bankroll += @bank/2
      @bank = 0
      puts "That's a draw"
    elsif @dealer.points < @player.points && @player.points < 22
      @player.bankroll += @bank
      @bank = 0
      puts "You've won!"
    end
  end

  def read(move)
    case move
    when "0"
      skip_move
    when "1"
      @player.card_added? ? "You can add card only one time" : add_card(@player)
    when "2"
      open_cards
    when "finish"
      abort "stop_program"
    end
  end
end
