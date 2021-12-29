defmodule TextClient.Impl.Player do

  @typep game :: Hangman.game
  @typep tally :: Hangman.tally
  @typep state :: { game, tally }

  @spec start() :: :ok
  def start do
    game = Hangman.new_game()
    tally = Hangman.tally(game)
    interact( {game, tally} )
  end

  @spec interact(state) :: :ok
  def interact do
    #feedback
    #diaply current word
    #get next guess
    #make move
    interact()

  end


end
