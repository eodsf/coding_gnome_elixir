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
  def interact( {_game, tally = %{ game_state: :won} } ) do
    IO.puts "Congrats, you won the game - the word was #{tally.letters |> Enum.join}"
  end


  def interact( {_game, tally = %{ game_state: :lost} } ) do
    IO.puts "Commiserations, you lost the game - the word was #{tally.letters |> Enum.join}"
  end


 def interact( {game, tally} ) do
    IO.puts feedback_for(tally)
    IO.puts current_word(tally)
    Hangman.make_move(game, get_guess())
    |> interact()

  end

  def feedback_for(tally = %{game_state: :initializing }) do
    IO.puts "Welcome to the game. The word to guess has #{tally.letters |> length} letters"
  end

  def feedback_for(%{ game_state: :good_guess}), do: IO.puts "Good guess!"
  def feedback_for(%{ game_state: :bad_guess}), do: IO.puts "Bad guess! That letter is not in the word"
  def feedback_for(%{ game_state: :already_used}), do: IO.puts "Sorry, you alrady used that letter."

  def current_word(tally) do
    [
    "\nWord so far:\t", tally.letters |> Enum.join(" "),
    "\nTurns left:\t", tally.turns_left |> to_string(),
    "\nUsed so far:\t", tally.used |> Enum.join(","),
    ]
  end

  def get_guess() do
    IO.gets("Your guess ? ")
    |> String.trim
    |> String.downcase
  end
end