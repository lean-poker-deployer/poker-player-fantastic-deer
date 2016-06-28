require_relative 'card'

class Hand
  def initialize(hole_cards, community_cards)
    @hole_cards = hole_cards.map { |card| Card.new(card) }
    @community_cards = community_cards.map { |card| Card.new(card) }
  end

  def pocket_pair?
    @hole_cards[0].value == @hole_cards[1].value
  end

  def highest_pocket_card_value
    @hole_cards.map { |card| card.value }.max
  end

  def suited_pocket_connector?
    (@hole_cards[0].value - @hole_cards[1].value).abs == 1 && suited_pocket?
  end

  def suited_pocket?
    @hole_cards[0].suit == @hole_cards[1].suit
  end

end