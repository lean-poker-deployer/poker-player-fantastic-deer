

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
    if hand.pocket_pair? && hand.highest_pocket_card_value >= 10
      10000
    else
      0
    end
  end

  def heads_up_strategy
    if (hand.pocket_pair? && hand.highest_pocket_card_value >= 6) || (hand.suited_pocket_connector? && hand.highest_pocket_card_value >= 13)
      10000
    else
      if pre_flop?
        if hand.highest_pocket_card_value > 7 && call < me['stack'] / 4
          call
        else
          0
        end
      else
        return call if hand.pair_with_my_card? && call < me['stack'] / 4
        return 10000 if hand.two_pair_with_my_card?
        0
      end
    end
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