class Game
  attr_accessor :player_1, :player_2, :board

  # Defines a constant WIN_COMBINATIONS with arrays for each win combination
  WIN_COMBINATIONS = [
    # Horizontal wins
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    # Vertical wins
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    # Diagonal wins
    [0, 4, 8],
    [2, 4, 6]
  ]

  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    @player_1 = player_1
    @player_2 = player_2
    @board = board
  end

  # Returns the correct player's turn player_1 "X" or player_2 "O"
  # is 0 considered even?
  def current_player
    @board.turn_count.odd? ? player_2 : player_1
  end

  # Returns true if the board has been won, is a draw, or is full
  def over?
    @board.full? || won? != false
    #if @board.full? || @board.won?
    #  true
    #else
    #  false
    #end
  end

  # Return false/nil if there is no win combination present in the board and
  # return the winning combination indexes as an array if there is a win
  def won?
    win_combo = WIN_COMBINATIONS.detect do |combination|
      @board.cells[combination[0]] == @board.cells[combination[1]] &&
      @board.cells[combination[1]] == @board.cells[combination[2]] &&
      @board.taken?(combination[0] + 1)
    end
    win_combo == nil ? false : win_combo

    #empty_board = @board.cells.all? do |cell|
    #  cell.nil? || cell == " "
    #end
    #if empty_board
    #  false
    #else
    #  # For each win_combination in WIN_COMBINATIONS
    #  # win_combination is a 3 element array of indexes that compose a win, [0,1,2]
    #  WIN_COMBINATIONS.each do |win_combination|
    #    # grab each index from the win_combination that composes a win.
    #    win_index_1 = win_combination[0]
    #    win_index_2 = win_combination[1]
    #    win_index_3 = win_combination[2]
    #    position_1 = @board.cells[win_index_1] # load the value of the board at win_index_1
    #    position_2 = @board.cells[win_index_2] # load the value of the board at win_index_2
    #    position_3 = @board.cells[win_index_3] # load the value of the board at win_index_3
    #    # puts "#{win_combination}"
    #    if (position_1 == "X" && position_2 == "X" && position_3 == "X") ||
    #       (position_1 == "O" && position_2 == "O" && position_3 == "O")
    #       return win_combination # return the win_combination indexes that won.
    #    else
    #       false
    #    end
    #  end
    #  false
    #end
  end

  # Returns true if the board has not been won and is full
  # and false if the board is not won and the board is not full,
  # and false if the board is won
  def draw?
     @board.full? && !won?

    #if won? || !full?
    #  false
    #else
    #  true
    #end
  end

  # Return the token, "X" or "O" that has won the game given a winning board
  def winner
    won? ? @board.cells[won?[0]] : nil
  end

  # Makes valid moves
  def turn
    result = nil
    while result == nil
      # puts "Player #{current_player.token} turn"
      result = current_player.move(@board.cells)
      if @board.valid_move?(result)
        @board.update(result, current_player)
      else
        @board.display
        result = nil
      end
    end
  end

  # Define your play method below
  def play
    while !over?
      @board.display
      turn
    end
    @board.display
    if won?
      puts "Congratulations #{winner}!"
    else
      puts "Cat\'s Game!"
    end
  end
end
