

class Card
  def initialize(card)
    high_values = { 'J' => 11, 'Q' => 12, 'K' => 13, 'A' => 14 }

    @rank = card['rank']
    @suit = card['suit']
    @value = @rank.to_i
  end
end