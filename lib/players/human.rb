module Players
  class Human < Player
    # Makes valid moves
    def move(board)
      puts "Player #{self.token} turn"
      puts "Please enter a position 1-9:"
      input = STDIN.gets.chomp
    end
  end
end
