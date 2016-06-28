
class Player

  VERSION = "Bluff a lot"

  def bet_request(game_state)
    me = game_state['players'][game_state['in_action']]
    hole_cards = me['hole_cards']

    if hole_cards[0]['rank'] == hole_cards[1]['rank']
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
