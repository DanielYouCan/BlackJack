require_relative './player'
require_relative './dealer'
require_relative './hand'
require_relative './main'

class Game
  attr_accessor :player, :dealer

  def initialize(player_name)
    @dealer = Dealer.new
    @bank = 0
    @player = Player.new(player_name)
  end

  def game_interface(interface)
    @interface = interface
  end

  def hand_settings
    @round_over = false
    @player.new_hand
    @dealer.new_hand
    @bank = 0
    @player.bankroll -= 10
    @dealer.bankroll -= 10
    @bank += 20
  end

  def game_preset
    hand_settings
    @deck = Deck.new
    @player.hand.deal_cards(@deck)
    @dealer.hand.deal_cards(@deck)
    puts "Your cards: #{@player.hand.cards} points: #{@player.hand.points}"
    puts "Dealer's cards **"
  end

  def new_round
    puts 'New round:'
    game_preset
    loop do
      @interface.options
      move = gets.chomp
      read(move)
      @dealer.dealer_move(@deck, @player) if @player.hand.cards_not_shown?
      if @player.hand.cards_shown? && @round_over == false
        round_results
        @round_over = true
      end
      break if @round_over == true
    end

    if @player.bankroll > 0 && @dealer.bankroll > 0
      new_round
    else
      @interface.new_game
    end
  end

  def round_results
    if draw?
      @dealer.bankroll += @bank / 2
      @player.bankroll += @bank / 2
      puts "That's a draw! Money left: #{@player.bankroll}"
    elsif dealer_wins?
      @dealer.bankroll += @bank
      puts "You've lost this round! Money left: #{@player.bankroll}"
    elsif player_wins?
      @player.bankroll += @bank
      puts "You've won! Money left: #{@player.bankroll}"
    end
  end

  def draw?
    @dealer.hand.points == @player.hand.points ||
      @player.hand.points > 21 && @dealer.hand.points > 21
  end

  def player_wins?
    @dealer.hand.points < @player.hand.points && @player.hand.points < 22 ||
      @dealer.hand.points > @player.hand.points && @dealer.hand.points > 21
  end

  def dealer_wins?
    @dealer.hand.points > @player.hand.points && @dealer.hand.points < 22 ||
      @dealer.hand.points < @player.hand.points && @player.hand.points > 21
  end

  def end_round
    puts "#{@player.name}'s results: "
    @player.hand.open_cards
    puts "Dealer's results: "
    @dealer.hand.open_cards
    round_results
    @round_over = true
  end

  def read(move)
    case move
    when '0'
      @player.hand.skip_move
    when '1'
      if @player.hand.card_added?
        puts 'You can add card only one time'
      else
        @player.hand.take_card(@deck)
        puts "Your cards: #{@player.hand.cards} points: #{@player.hand.points}"
      end
    when '2'
      end_round
    when 'finish'
      abort 'stop_game'
    end
  end
end
