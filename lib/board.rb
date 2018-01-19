class Board
  attr_accessor :cells

  def initialize(cells = nil)
    @cells = cells || Array.new(9, " ")
  end

  def reset!
    @cells.clear
    @cells = Array.new(9, " ")
  end

  def display
    puts " #{@cells[0]} | #{@cells[1]} | #{@cells[2]} "
    puts "-----------"
    puts " #{@cells[3]} | #{@cells[4]} | #{@cells[5]} "
    puts "-----------"
    puts " #{@cells[6]} | #{@cells[7]} | #{@cells[8]} "
  end

  # Returns the value of the board cell
  def position(input)
    if input.to_i.between?(1,9)
      @cells[input.to_i - 1]
    end
  end

  # Return true if every element in the board contains either an "X" or an "O"
  def full?
    #@cells.all? {|cell| cell == "X" || cell == "O"}
    @cells.all? do |cell|
      cell == "X" || cell == "O"
    end
  end

  # Counts occupied positions
  # Returns the amount of turns based on cell value
  def turn_count
    #@cells.select {|cell| cell == "X" || cell == "O"}.size
    counter = 0
    @cells.each do |cell|
      if cell != " " && cell != ""
        counter += 1
      end
    end
    counter
  end


  # Returns true/false based on position in board
  # returns true if the position is X or O
  # returns false if the position is empty or blank
  def taken?(input)
    @cells[input.to_i - 1] == "X" || @cells[input.to_i - 1] == "O"
  end

  # Accepts an index to check and returns true if the move is valid and false or nil if not
  # returns true for user input between 1-9 that is not taken
  def valid_move?(input)
    input.to_i.between?(1,9) && !taken?(input)
  end

  # Updates the cells in the board with the player token according to the input
  def update(input, player)
    @cells[input.to_i - 1] = player.token
  end

end
