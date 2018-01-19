module Players
  class Computer < Player
    # Makes valid moves
    def move(board)
      puts "Player #{self.token} turn"
      sleep(2)
      num = valid_random_number(board)
      puts "> #{num}"
      num
    end

    def valid_random_number(board)
      num = rand(1..9)
      puts "random num #{num} #{board[num.to_i - 1]}"
      if board[num.to_i - 1] == " " || board[num.to_i - 1] == ""
        num
      else
        valid_random_number(board)
      end
      #get error with below code... why?
      #/home/nichia/ttt-with-ai-project-cb-000/lib/players/computer.rb:15:in `valid_random_number': undefined method `valid_move?' for [" ", " ", "
      #board.valid_move?(num.to_s) ? num : valid_random_number
    end
  end
end
