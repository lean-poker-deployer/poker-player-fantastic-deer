

class BettingStrategy
  def initialize(game_state)
    @game_state = game_state
  end

  def bet
    if heads_up?
      heads_up_strategy
    else
      normal_strategy
    end
  end

  def normal_strategy
    return allin if pocket_pair_with_value_at_least?(10)
    0
  end

  def allin
    10000
  end

  def pocket_pair_with_value_at_least?(min_value)
    hand.pocket_pair? && hand.highest_pocket_card_value >= min_value
  end

  def heads_up_strategy
    if pre_flop?
      return allin if pocket_pair_with_value_at_least?(6) || (suited_connector_with_value_at_least?(13))
      return call if highest_card_with_value_at_least?(7) && cheap_call?
    else
      return call if hand.pair_with_my_card? && cheap_call?
      return allin if hand.two_pair_with_my_card?
    end
    0
  end

  def cheap_call?
    call < me['stack'] / 4
  end

  def highest_card_with_value_at_least?(min_value)
    hand.highest_pocket_card_value > min_value
  end

  def suited_connector_with_value_at_least?(min_value)
    hand.suited_pocket_connector? && hand.highest_pocket_card_value >= min_value
  end

  def call
    @game_state['current_by_in'] - me['bet']
  end

  def pre_flop?
    @game_state['community_cards'].count == 0
  end

  def heads_up?
    players_in_game < 3
  end

  def hand
    Hand.new(me['hole_cards'], @game_state['community_cards'])
  end

  def me
    @game_state['players'][@game_state['in_action']]
  end

  def players_in_game
    @game_state['players'].select { |player| player['status'] != 'out' }.count
  end
end