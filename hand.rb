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
    pocket_pair? && highest_pocket_card_value >= 10
  end

  def highest_pocket_card_value
    @hole_cards.map { |card| card.value }.max
  end

  def pocket_connector?
    (@hole_cards[0].value - @hole_cards[1].value).abs == 1
  end

  def suited_pocket?
    @hole_cards[0].suit == @hole_cards[1].suit
  end

  def high_suited_pocket_connector?
    pocket_connector? && suited_pocket? && highest_pocket_card_value >= 13
  end
end