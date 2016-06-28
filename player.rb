require_relative 'hand'

class Player

  VERSION = "Get a bit less agressive"

  def bet_request(game_state)
    me = game_state['players'][game_state['in_action']]

    hand = Hand.new(me['hole_cards'], game_state['community_cards'])

    if hand.high_pocket_pair?
      10000
    else
      0
    end
  end

  def showdown(game_state)

  end
end
