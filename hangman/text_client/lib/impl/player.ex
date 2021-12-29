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

  @spec interact( {game, tally} ) :: :ok
  def interact( {_game, _tally = %{ game_state: :won} } ) do
    IO.puts "Congrats, you won the game"
  end


  def interact( {_game, tally = %{ game_state: :lost} } ) do
    IO.puts "Commiserations, you lost the game - the word was #{tally.letters |> Enum.join}"
  end


 def interact( {game, tally} ) do
    #feedback
    IO.puts feedback_for(tally)
    #diaply current word
    #get next guess
    #make move
    # commented out for now
    #interact()

  end

  def feedback_for(tally = %{game_state: :initializing }) do
    IO.puts "Welcome to the game. The word to guess has #{tally.letters |> length}"
  end

  def feedback_for(%{ game_state: :good_guess}), do: IO.puts "Good guess!"
  def feedback_for(%{ game_state: :bad_guess}), do: IO.puts "Bad guess! That letter is not in the word"
  def feedback_for(%{ game_state: :already_used}), do: IO.puts "Sorry, you alrady used that letter."
end
