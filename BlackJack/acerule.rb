module AceRule
  def check_ace(player)
    ace_on_hands = player.cards & %w(A+ A<> A<3 A^)
    if player.points > 21 && !(ace_on_hands.empty?)
      player.points -= 10
    end
  end
end