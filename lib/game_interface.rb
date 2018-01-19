class GameInterface

  def start
    input = ' '
    while input != 'exit'
      puts "Welcome to Tic Tac Toe!"
      puts "Enter \'0\' to watch computer X plays against computer O"
      puts "Enter \'1\' for a one player game, to play against the computer"
      puts "Enter \'2\' for a two player game, to play with a friend"
      puts "Enter \'exit\' or \'e\' to quite"
      input = STDIN.gets.chomp.downcase
      case input
      when '0'
        zero_player
      when '1'
        one_player
      when '2'
        two_player
      when 'exit','e'
        input = 'exit'
      end
    end
  end

  def zero_player
    if pick_firstplay_token == 'X'
      player_1 = Players::Computer.new('X')
      player_2 = Players::Computer.new('O')
    else
      player_1 = Players::Computer.new('O')
      player_2 = Players::Computer.new('X')
    end
    Game.new(player_1, player_2).play
  end

  def one_player
    start_first = play_first?
    token = pick_token
    if start_first
      if token == 'X'
        player_1 = Players::Human.new('X')
        player_2 = Players::Computer.new('O')
      else
        player_1 = Players::Human.new('O')
        player_2 = Players::Computer.new('X')
      end
    else
      if token == 'X'
        player_1 = Players::Computer.new('O')
        player_2 = Players::Human.new('X')
      else
        player_1 = Players::Computer.new('X')
        player_2 = Players::Human.new('O')
      end
    end
    Game.new(player_1, player_2).play
  end

  def two_player
    token = pick_firstplay_token
    if token == 'X'
      player_1 = Players::Human.new('X')
      player_2 = Players::Human.new('O')
    else
      player_1 = Players::Human.new('O')
      player_2 = Players::Human.new('X')
    end
    Game.new(player_1, player_2).play
  end

  def play_first?
    puts "Would you like to go first? (enter \'yes\' or \'no\')"
    input = STDIN.gets.chomp.downcase
    case input
    when 'yes', 'y'
      true
    when 'no', 'n'
      false
    when other
      play_first?
    end
  end

  def pick_token
    puts "Would you like to be player \'X\' or \'O\'?"
    input = STDIN.gets.chomp.upcase
    if input == 'X' || input == 'O'
      input
    else
      pick_token
    end
  end

  def pick_firstplay_token
    puts "Would you like \'X\' or \'O\' to play first?"
    input = STDIN.gets.chomp.upcase
    if input == 'X' || input == 'O'
      input
    else
      pick_firstplay_token
    end
  end
end
