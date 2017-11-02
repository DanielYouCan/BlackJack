require_relative './deck'
require_relative './cards'

class Hand
  attr_accessor :cards_shown, :cards, :points, :card_added

  def initialize
    @cards = []
    @points = 0
    @cards_shown = false
    @card_added = false
  end

  def card_added?
    @card_added
  end

  def cards_shown?
    @cards_shown
  end

  def cards_not_shown?
    !@cards_shown
  end

  def deal_cards(deck)
    @cards = deck.initial_deal
    count_points(@cards.first)
    count_points(@cards.last)
  end

  def take_card(deck)
    @card_added = true
    @cards << deck.add_card
    count_points(@cards.last)
  end

  def skip_move
    puts 'Move is passed to another player'
  end

  def open_cards
    @cards_shown = true
    @points = 0
    @cards.each do |card|
      count_points(card)
    end
    p "#{@cards} points: #{@points}"
  end

  def count_points(card)
    @points += card.value
    check_ace
  end

  def check_ace
    @points -= 10 if @points > 21 && @cards.any? { |card| card.value == 11 }
  end

  def hand_full?
    @cards.size == 3
  end
end
