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

    if hand.high_pocket_pair? # || hand.high_suited_pocket_connector?
      10000
    else
      0
    end
  end

  def showdown(game_state)

  end
end
