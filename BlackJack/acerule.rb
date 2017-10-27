module AceRule
  def check_ace(player)
    if player.points > 20 && (player.cards & %w(A+ A<> A<3 A^))
      player.points -= 10
    end
  end
end