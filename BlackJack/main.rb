require_relative './player'
require_relative './dealer'
require_relative './hand'
require_relative './game_logic'

class Game
  def initialize
    @dealer = Dealer.new
    @game_result = GameResult.new
    @bank = 0
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
    @player.card_added = false
    @dealer.card_added = false
    @player.hand.points = 0
    @dealer.hand.points = 0
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
      @dealer.dealer_move(@deck, @player) if @player.hand.cards_not_shown?
      if @player.hand.cards_shown?
        round_results
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

  def round_results
    if @dealer.hand.points == @player.hand.points || (@player.hand.points > 21 && @dealer.hand.points > 21)
      @dealer.bankroll += @bank / 2
      @player.bankroll += @bank / 2
      @bank = 0
      puts "That's a draw"
      puts "Money left: #{@player.bankroll}"
    elsif (@dealer.hand.points > @player.hand.points && @dealer.hand.points < 22) || (@dealer.hand.points < @player.hand.points && @player.hand.points > 21)
      @dealer.bankroll += @bank
      @bank = 0
      puts "You've lost this round"
      puts "Money left: #{@player.bankroll}"
    elsif (@dealer.hand.points < @player.hand.points && @player.hand.points < 22) || (@dealer.hand.points > @player.hand.points && @dealer.hand.points > 21)
      @player.bankroll += @bank
      @bank = 0
      puts "You've won!"
      puts "Money left: #{@player.bankroll}"
    end
  end

  def read(move)
    case move
    when '0'
      @player.hand.skip_move
    when '1'
      @player.card_added? ? 'You can add card only one time' : @player.hand.take_card(@deck)
    when '2'
      puts "#{@player.name}'s resuts: "
      @player.hand.open_cards
      puts "Dealer's resuts: "
      @dealer.hand.open_cards
      round_results
    when 'finish'
      abort 'stop_program'
    end
  end
end
