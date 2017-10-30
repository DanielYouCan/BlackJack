require_relative './player'
require_relative './dealer'
require_relative './acerule'
require_relative './hand'
require_relative './game_logic'

class Game
  include AceRule

  def initialize
    @dealer = Dealer.new
    @game_result = GameResult.new
  end

  def start_game
    puts "What's your name?"
    player_name = gets.chomp
    player = Player.new(player_name)
    @player = player
    new_round
  end

  private

  def hand_settings
    @hand = Hand.new
    @player.card_added = false
    @dealer.card_added = false
    @dealer.points = 0
    @player.points = 0
    @player.bankroll -= 10
    @dealer.bankroll -= 10
    @game_result.bank += 20
  end

  def game_preset
    hand_settings
    @hand.deal_cards(@player)
    @hand.deal_cards(@dealer)
    @hand.count_points(@player)
    @hand.count_points(@dealer)
    puts "Your cards: #{@player.cards} points: #{@player.points}"
    puts "Dealer's cards **"
  end

  def new_game
    puts 'Do you want to play again? Yes/No'
    answer = gets.chomp
    if answer == 'Yes'
      @player.bankroll = 100
      @dealer.bankroll = 100
      new_round
    elsif answer == 'No'
      puts 'Game is over'
    end
  end

  def new_round
    puts 'New round:'
    game_preset
    loop do
      options
      move = gets.chomp
      read(move)
      @dealer.dealer_move(@player, @hand) if @hand.cards_not_shown?
      if @hand.cards_shown?
        @game_result.round_results(@player, @dealer)
        break
      end
    end

    if @player.bankroll > 0 && @dealer.bankroll > 0
      new_round
    else
      new_game
    end
  end

  def options
    if @player.card_added?
      puts "Choose what you'd like to do:
      0 - skip a move
      2 - open cards
      finish - quit game"
    else
      puts "Choose what you'd like to do:
      0 - skip a move
      1 - add a card
      2 - open cards
      finish - quit game"
    end
  end

  def read(move)
    case move
    when '0'
      @hand.skip_move
    when '1'
      @player.card_added? ? 'You can add card only one time' : @hand.add_card(@player, @dealer)
    when '2'
      @hand.open_cards(@player, @dealer)
      @game_result.round_results(@player, @dealer)
    when 'finish'
      abort 'stop_program'
    end
  end
end
