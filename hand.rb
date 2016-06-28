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
    pocket_card_values.max
  end

  def pocket_card_values
    @hole_cards.map { |card| card.value }
  end

  def suited_pocket_connector?
    (@hole_cards[0].value - @hole_cards[1].value).abs == 1 && suited_pocket?
  end

  def suited_pocket?
    @hole_cards[0].suit == @hole_cards[1].suit
  end

  def all_cards
    (@hole_cards + @community_cards).sort_by { |l, r| l.value < r.value }
  end

  def pair_with_my_card?
    !pocket_pair? && (pair_with_hole_card_index?(0) || pair_with_hole_card_index?(1))
  end

  def pair_with_hole_card_index?(index)
    community_card_values.include?(@hole_cards[index].value)
  end

  def two_pair_with_my_card?
    !pocket_pair? && pair_with_hole_card_index?(0) && pair_with_hole_card_index?(1)
  end

  def community_card_values
    @community_cards.map { |card| card.value }
  end

end