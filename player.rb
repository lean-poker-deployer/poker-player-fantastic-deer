require_relative 'hand'
require_relative 'betting_strategy'

class Player

  VERSION = "Get a bit less agressive"

  def bet_request(game_state)
    [0,BettingStrategy.new(game_state).bet.to_i].max
  rescue Exception => e
    STDERR.puts e.message
    STDERR.puts e.backtrace
    0
  end



  def showdown(game_state)

  end
end
