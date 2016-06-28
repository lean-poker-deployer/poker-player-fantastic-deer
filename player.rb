require_relative 'hand'

class Player

  VERSION = "Bluff a lot"

  def bet_request(game_state)
    me = game_state['players'][game_state['in_action']]

    hand = Hand.new(me['hole_cards'], game_state['community_cards'])

    if hand.pocket_pair?
      10000
    else
      if rand > 0.5
        10000
      else
        0
      end
    end
  end

  def showdown(game_state)

  end
end
