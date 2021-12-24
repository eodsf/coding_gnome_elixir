defmodule Hangman.Impl.Game do

  @type t :: %Hangman.Impl.Game{
    turns_left: integer,
    game_state: Hangman.state,
    letters: list(String.t),
    used: MapSet.t(String.t)
  }

  defstruct(
    turns_left: 7,
    game_state: :initialzing,
    letters: [],
    used: MapSet.new()
  )

  def new_game do
    %Hangman.Impl.Game{
      letters: Dictionary.random_word |> String.codepoints
    }
  end

  def make_move(game, guess) do
  end

end
