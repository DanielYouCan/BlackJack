class GameResult
  attr_accessor :bank

  def initialize
    @bank ||= 0
  end

  def round_results(player, dealer)
    if dealer.points == player.points || (player.points > 21 && dealer.points > 21)
      dealer.bankroll += @bank / 2
      player.bankroll += @bank / 2
      @bank = 0
      puts "That's a draw"
      puts "Money left: #{player.bankroll}"
    elsif (dealer.points > player.points && dealer.points < 22) || (dealer.points < player.points && player.points > 21)
      dealer.bankroll += @bank
      @bank = 0
      puts "You've lost this round"
      puts "Money left: #{player.bankroll}"
    elsif (dealer.points < player.points && player.points < 22) || (dealer.points > player.points && dealer.points > 21)
      player.bankroll += @bank
      @bank = 0
      puts "You've won!"
      puts "Money left: #{player.bankroll}"
    end
  end
end
