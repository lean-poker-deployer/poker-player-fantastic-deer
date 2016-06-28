require_relative 'hand'

class Player

  VERSION = "Get a bit less agressive"

  def bet_request(game_state)
    [0,bet(game_state).to_i].max
  rescue Exception => e
    STDERR.puts e.message
    STDERR.puts e.backtrace
    0
  end

  def bet(game_state)
    if heads_up?(game_state)
      heads_up_strategy(game_state)
    else
      normal_strategy(game_state)
    end
  end

  def normal_strategy(game_state)
    if hand(game_state).pocket_pair? && hand(game_state).highest_pocket_card_value >= 10
      10000
    else
      0
    end
  end

  def heads_up_strategy(game_state)
    if (hand(game_state).pocket_pair? && hand(game_state).highest_pocket_card_value >= 6) || (hand(game_state).suited_pocket_connector? && hand(game_state).highest_pocket_card_value >= 13)
      10000
    else
      if pre_flop(game_state)
        if hand(game_state).highest_pocket_card_value > 7 && call(game_state) < me(game_state)['stack'] / 4
          call(game_state)
        else
          0
        end
      else
        return call(game_state) if hand(game_state).pair_with_my_card? && call(game_state) < me(game_state)['stack'] / 4
        return 10000 if hand(game_state).two_pair_with_my_card?
        0
      end
    end
  end

  def call(game_state)
    game_state['current_by_in'] - me(game_state)['bet']
  end

  def pre_flop(game_state)
    game_state['community_cards'].count == 0
  end

  def heads_up?(game_state)
    players_in_game(game_state) < 3
  end

  def hand(game_state)
    Hand.new(me(game_state)['hole_cards'], game_state['community_cards'])
  end

  def me(game_state)
    game_state['players'][game_state['in_action']]
  end

  def players_in_game(game_state)
    game_state['players'].select { |player| player['status'] != 'out' }.count
  end

  def showdown(game_state)

  end
end
