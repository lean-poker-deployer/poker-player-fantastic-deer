require_relative 'card'

class Hand
  def initialize(hole_cards, community_cards)
    @hole_cards = hole_cards.map { |card| Card.new(card) }
    @community_cards = community_cards.map { |card| Card.new(card) }
  end

  def pocket_pair?
    @hole_cards[0].value == @hole_cards[1].value
  end

  def high_pocket_pair?
    pocket_pair? && @hole_cards[0].value >= 10
  end
end