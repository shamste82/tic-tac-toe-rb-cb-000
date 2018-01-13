WIN_COMBINATIONS = [
[0, 1, 2],
[3, 4, 5],
[6, 7, 8],
[0, 3, 6],
[1, 4, 7],
[2, 5, 8],
[0, 4, 8],
[2, 4, 6]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  user_input = input_to_index(input)
  if valid_move?(board, user_input)
    move(board, user_input, current_player(board))
    display_board(board)
    return
  end
  turn(board)
end

def turn_count(board)
  board.count{|xo| xo == "X" || xo == "O"}
end

def current_player(board)
  return turn_count(board).even? ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |combination|
      win_index_1 = combination[0]
      win_index_2 = combination[1]
      win_index_3 = combination[2]

      position_1 = board[win_index_1]
      position_2 = board[win_index_2]
      position_3 = board[win_index_3]

      if position_1 == "X" && position_2 == "X" && position_3 == "X"
        return combination
      end
      if position_1 == "O" && position_2 == "O" && position_3 == "O"
        return combination
      end
  end
  return false
end

def full?(board)
  for i in(0..8)
    if !position_taken?(board, i)
      return false
    end
  end
  return true
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  end
  return false
end

def over?(board)
  if won?(board)
    return true
  elsif draw?(board)
    return true
  elsif full?(board)
    return true
  end
  return false
end

def winner(board)
  combination = won?(board)
  if !combination
    return nil
  end
  if board[combination[0]] == "X" && board[combination[1]] == "X" && board[combination[2]] == "X"
    return "X"
  elsif board[combination[0]] == "O" && board[combination[1]] == "O" && board[combination[2]] == "O"
    return "O"
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if !winner(board)
    puts "Cat's Game!"
  elsif winner(board)
    winner = winner(board)
    puts "Congratulations #{winner}!"
  end
end
