require_relative './game'

class UserInterface
  attr_accessor :game

  def start_game
    puts "What's your name?"
    player_name = gets.chomp
    @game = Game.new(player_name)
    new_round
  end

  def game_preset
    @game.hand_settings
    @game.deck = Deck.new
    @game.player.hand.deal_cards(@game.deck)
    @game.dealer.hand.deal_cards(@game.deck)
    puts "Your cards: #{@game.player.hand.cards} points: #{@game.player.hand.points}"
    puts "Dealer's cards **"
 end

  def new_round
    puts 'New round:'
    game_preset
    loop do
      options
      move = gets.chomp
      read(move)
      @game.dealer.dealer_move(@game.deck, @game.player) if @game.player.hand.cards_not_shown?
      if @game.player.hand.cards_shown? && !@game.round_over
        @game.round_results
        @game.round_over = true
      end
      break if @game.round_over
    end

    if @game.player.bankroll > 0 && @game.dealer.bankroll > 0
      new_round
    else
      new_game
    end
  end

  def new_game
    puts 'Do you want to play again? Yes/No'
    answer = gets.chomp
    if answer == 'Yes'
      @game.player.bankroll = 100
      @game.dealer.bankroll = 100
      new_round
    elsif answer == 'No'
      puts 'Game is over'
    end
  end

  def options
    if @game.player.hand.card_added?
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

  def end_round
    puts "#{@game.player.name}'s results: "
    @game.player.hand.open_cards
    puts "Dealer's results: "
    @game.dealer.hand.open_cards
    @game.round_results
    @game.round_over = true
  end

  def read(move)
    case move
    when '0'
      @game.player.hand.skip_move
    when '1'
      if @game.player.hand.card_added?
        puts 'You can add card only one time'
      else
        @game.player.hand.take_card(@game.deck)
        puts "Your cards: #{@game.player.hand.cards} points: #{@game.player.hand.points}"
      end
    when '2'
      end_round
    when 'finish'
      abort 'stop_game'
    end
  end
end

UserInterface.new.start_game
