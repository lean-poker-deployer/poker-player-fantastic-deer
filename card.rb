

class Card
  attr_reader :rank
  attr_reader :suit
  attr_reader :value

  def initialize(card)
    high_values = { 'J' => 11, 'Q' => 12, 'K' => 13, 'A' => 14 }

    @rank = card['rank']
    @suit = card['suit']
    @value = high_values.has_key?(@rank) ? high_values[@rank] : @rank.to_i
  end
end