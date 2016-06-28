require_relative 'hand'

class Player

  VERSION = "Get a bit less agressive"

  def bet_request(game_state)
    [0,bet(game_state).to_i].max
  rescue Excpetion => e
    STDERR.p e.message
    0
  end

  def bet(game_state)
    me = game_state['players'][game_state['in_action']]

    hand = Hand.new(me['hole_cards'], game_state['community_cards'])

    if players_in_game(game_state) > 2
      if hand.pocket_pair? && hand.highest_pocket_card_value >= 10
        10000
      else
        0
      end
    else
      if (hand.pocket_pair? && hand.highest_pocket_card_value >= 6) || (hand.suited_pocket_connector? && hand.highest_pocket_card_value >= 13)
        10000
      else
        0
      end
    end
  end

  def players_in_game(game_state)
    game_state['players'].select { |player| player['status'] != 'out' }.count
  end

  def showdown(game_state)

  end
end
