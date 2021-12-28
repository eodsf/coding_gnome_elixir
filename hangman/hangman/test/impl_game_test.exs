defmodule HangmanImplGameTest do
  use ExUnit.Case
  alias Hangman.Impl.Game

  test "new_game_return_structure" do
    game = Game.new_game

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert length(game.letters) > 0

  end

  test "new game returns correct word" do
    game = Game.new_game("wombat")
    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert game.letters == ["w", "o", "m", "b", "a", "t"]
  end

  test "state does not change if game is won or lost" do
    for state <-[:won, :lost] do
      game = Game.new_game("wombat")
      game = Map.put(game, :game_state, :won)
      {new_game, _tally} = Game.make_move(game, "x")
      assert new_game == game
    end
  end

  test "a duplicate letter is reported" do
    game = Game.new_game()
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state != :already_used
    {game, _tally} = Game.make_move(game, "y")
    assert game.game_state != :already_used
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state == :already_used
  end

  test "letters used are reported" do
    game = Game.new_game()
    {game, _tally} = Game.make_move(game,"x")
    {game, _tally} = Game.make_move(game,"y")
    {game, _tally} = Game.make_move(game,"x")
    assert MapSet.equal?(game.used, MapSet.new(["x", "y"]))

  end

  test "we recognize a letter in the word" do
    game = Game.new_game("wombat")
    { game, tally} = Game.make_move(game, "m")
    assert tally.game_state == :good_guess
    { game, tally} = Game.make_move(game, "t")
    assert tally.game_state == :good_guess
  end

  test "we recognize a letter not in the word" do
    game = Game.new_game("wombat")
    { game, tally} = Game.make_move(game, "m")
    assert tally.game_state == :good_guess
    { game, tally} = Game.make_move(game, "x")
    assert tally.game_state == :bad_guess
  end


end
