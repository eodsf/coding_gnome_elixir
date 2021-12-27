defmodule Hangman do

  alias Hangman.Impl.Game
  alias Hangman.Type

  @type state :: :iinitializing | :won | :lost | :good_guess | :bad_guess | :already_used
  @opaque game :: Game.t

  @spec new_game() :: game
  defdelegate new_game, to: Game

  @spec make_move(game, String.t) :: {game, Type.tally}
  defdelegate make_move(game, guess), to: Game

end
