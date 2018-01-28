module Players

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

  CORNERS = [0, 2, 6, 8]

  CENTER = 4

  class Computer < Player

    def move(board)
      #puts "Player #{self.token} turn"
      #num = valid_random_number(board)
      num = ai_board(board)
      #puts "> #{num}"
<<<<<<< HEAD
      sleep(0)
=======
      sleep(0.5)
>>>>>>> aa60641dfc48eb30d4bf9649158a23db2bb261f4
      num
    end

    def valid_random_number(board)
      num = rand(1..9)
      #puts "random num #{num} #{board[num.to_i - 1]}"
      if board[num.to_i - 1] == " " || board[num.to_i - 1] == ""
        num
      else
        valid_random_number(board)
      end
      #get error with below code... why?
      #/home/nichia/ttt-with-ai-project-cb-000/lib/players/computer.rb:15:in `valid_random_number': undefined method `valid_move?' for [" ", " ", "
      #board.valid_move?(num.to_s) ? num : valid_random_number
    end

    def ai_board(board)
      #puts "board #{board}"
      if empty_board(board)
        num = start_random_number(board)
      else
        win_able = win(board)
        if win_able != nil
          num = win_able.to_s
        else
          block_able = block(board)
          if block_able !=nil
            num = block_able.to_s
          else
            if board[CENTER] == " " || board[CENTER] == ""
              num = (CENTER + 1).to_s
            else
              num = valid_random_number(board)
            end
          end
        end
      end
    end

    def empty_board(board)
       board.all? do |cell|
         cell.nil? || cell == " "
       end
    end

    def start_random_number(board)
      num = rand(1..9)
      #puts "start random num #{num} #{board[num.to_i - 1]}"
      #Odd number only for coners and center (1, 3, 5, 7, 9)
      if num.odd? && (board[num.to_i - 1] == " " || board[num.to_i - 1] == "")
        num
      else
        start_random_number(board)
      end
    end

    def win(board)
      # WIN_COMBINATIONS.detect does not work with below code... why?
      # have to break down each individual test case per .detect for it to work.... WHY?
      #win_combo = WIN_COMBINATIONS.detect do |combination|
      #  (board[combination[0]] == token && board[combination[1]] == token && board[combination[2]] == "") ||
      #  (board[combination[0]] == token && board[combination[2]] == token && board[combination[1]] == "") ||
      #  (board[combination[1]] == token && board[combination[2]] == token && board[combination[0]] == "")
      #end

      win_combo = WIN_COMBINATIONS.detect do |combination|
        board[combination[0]] == token &&
        board[combination[0]] == board[combination[1]] &&
        board[combination[2]] == " "
      end

      if win_combo == nil
        #puts "win_combo is #{win_combo} token #{token}"
        win_combo = WIN_COMBINATIONS.detect do |combination|
          board[combination[0]] == token &&
          board[combination[0]] == board[combination[2]] &&
          board[combination[1]] == " "          #puts ">>win_combo #{board[combination[0]]} #{board[combination[1]]} #{board[combination[2]]}"
        end
      end
      if win_combo == nil
        #puts "win_combo is #{win_combo} token #{token}"
        win_combo = WIN_COMBINATIONS.detect do |combination|
          board[combination[1]] == token &&
          board[combination[1]] == board[combination[2]] &&
          board[combination[0]] == " "
        end
      end
      #puts "win_combo is #{win_combo} token #{token}"

      if win_combo != nil
        win_index = win_combo.detect do |index|
          board[index] == " "
        end
        #puts ">>win_index #{win_index + 1}"
        win_index + 1
      end
    end

    def block(board)
      switched_token = switch_token

      win_combo = WIN_COMBINATIONS.detect do |combination|
        board[combination[0]] == switched_token &&
        board[combination[0]] == board[combination[1]] &&
        board[combination[2]] == " "
      end

      if win_combo == nil
        #puts "Block win_combo is #{win_combo} token #{switched_token}"
        win_combo = WIN_COMBINATIONS.detect do |combination|
          board[combination[0]] == switched_token &&
          board[combination[0]] == board[combination[2]] &&
          board[combination[1]] == " "
        end
      end
      if win_combo == nil
        #puts "Block win_combo is #{win_combo} token #{switched_token}"
        win_combo = WIN_COMBINATIONS.detect do |combination|
          board[combination[1]] == switched_token &&
          board[combination[1]] == board[combination[2]] &&
          board[combination[0]] == " "
        end
      end
      #puts "Block win_combo is #{win_combo} token #{switched_token}"

      if win_combo != nil
        win_index = win_combo.detect do |index|
          board[index] == " "
        end
        #puts ">>Block win_index #{win_index + 1}"
        win_index + 1
      end
    end

    def switch_token
      token == "X" ? "O" : "X"
    end
  end #--- Computer
end
