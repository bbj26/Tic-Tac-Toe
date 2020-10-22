class Player
  @@number_of_players = 1;
  attr_accessor :name, :mark, :number_of_players
  def initialize
    print "\nEnter the name for player #{@@number_of_players}:\t"
    name = gets
    name ||= ''
    name.chomp!
    @name = name
    @mark = ""
    @@number_of_players += 1
  end

  def self.restartNumberOfPlayers
    @@number_of_players = 1
  end

  def getMark
    self.mark
  end

  def setMark=(m)
    self.mark = m
  end

  def showPlrInfo
    print "\n### #{self.name} plays with #{self.mark}\t\t"
  end
end

class Computer < Player
  def initialize
    @name = "Computer"
  end
  
  def computerPlay(arr)
    compPlay(arr)
  end

  private

  def compPlay(array)
    case 
    when (array[0] == "X" && array[2] == "X") && array[1] == " " then 1
    when (array[3] == "X" && array[5] == "X") && array[4] == " " then 4
    when (array[6] == "X" && array[8] == "X") && array[7] == " " then 7
    when (array[0] == "X" && array[6] == "X") && array[3] == " " then 3
    when (array[1] == "X" && array[7] == "X") && array[4] == " " then 4
    when (array[2] == "X" && array[8] == "X") && array[5] == " " then 5
    when (array[0] == "X" && array[8] == "X") && array[4] == " " then 4
    when (array[2] == "X" && array[6] == "X") && array[4] == " " then 4
    when (array[0] == "X" && array[1] == "X") && array[2] == " " then 2
    when (array[1] == "X" && array[2] == "X") && array[0] == " " then 0
    when (array[3] == "X" && array[4] == "X") && array[5] == " " then 5
    when (array[4] == "X" && array[5] == "X") && array[3] == " " then 3
    when (array[6] == "X" && array[7] == "X") && array[8] == " " then 8
    when (array[7] == "X" && array[8] == "X") && array[6] == " " then 6
    when (array[0] == "X" && array[3] == "X") && array[6] == " " then 6
    when (array[3] == "X" && array[6] == "X") && array[0] == " " then 0
    when (array[1] == "X" && array[4] == "X") && array[7] == " " then 7
    when (array[4] == "X" && array[7] == "X") && array[1] == " " then 1
    when (array[2] == "X" && array[5] == "X") && array[8] == " " then 8
    when (array[5] == "X" && array[8] == "X") && array[2] == " " then 2
    when (array[0] == "X" && array[4] == "X") && array[8] == " " then 8
    when (array[4] == "X" && array[8] == "X") && array[1] == " " then 1
    when (array[2] == "X" && array[4] == "X") && array[6] == " " then 6
    when (array[4] == "X" && array[6] == "X") && array[2] == " " then 2
    else 
      rand(1..9)
    end
  end
end

class TicTacToe
  attr_accessor :moves, :player1_flag, :choice
  

  def gameExplanation
    puts "        ----------    TIC-TAC-TOE    ----------      "
    puts ""
    puts "Tic-tac-toe, noughts and crosses, or Xs and Os, is a game for two players, X and O, who take turns marking the spaces in a 3×3 grid." 
    puts "The player who succeeds in placing three of their marks in a horizontal, vertical, or diagonal row is the winner. "
    puts ""
    puts "Here is how the board looks:"
    puts ""
    puts "   1  |  2  |  3   "
    puts "______|_____|______"
    puts "      |     |      "
    puts "   4  |  5  |  6   "
    puts "______|_____|______"
    puts "      |     |      "
    puts "   7  |  8  |  9   "
    puts ""
    puts "Each grid cell is marked with a number. When it's your turn, you have to choose a number of a cell you want to mark with X or O"
    puts ""
    puts ""

  end
  
  def end_game=(n)
    @@end_game = n
  end

  def end_game
    @@end_game
  end

  def startPlay
    self.play
  end  

  def newGame?
    puts "Do you want to play again? (\"y\" -> yes, \"n\" -> no)"
    again = gets.chomp
    until again == "y" || again == "Y" || again == "n" || again == "N"
      puts "Wrong input. Enter \"y\" or \"n\""
      again = gets.chomp
    end

    case again
    when "y" || "Y" then
      puts "Starting new game..."
      #sleep 2
      @@moves = @@moves.map {|elem| elem = " "}
      @@player1_flag = true
      @@end_game = false
      @@choice = ""
      Player.restartNumberOfPlayers
      self.startPlay
      return true
    when "n" || "N" then 
      puts "Thanks for playing. Exiting..." 
      exit(true)
    end
  end
  private

  @@player1_flag = true
  @@end_game = false
  @@moves = Array.new(9, " ")
  @@choice = ""
  
  def play
    if chooseTypeOfPlay == 1
      puts "Game mode selected: 1 vs 1"
      player1 = Player.new
      player1.setMark = "X"
      player2 = Player.new
      player2.setMark = "O"
      player1.showPlrInfo
      player2.showPlrInfo 
      
      while (@@moves.include?(" ") && end_game == false) do
        if (@@player1_flag == true && end_game == false)
          if playersTurn(player1) == true
            @@player1_flag = false
            checkResult(@@moves, player1, player2)
          end
        elsif (@@player1_flag == false && end_game == false)
          if playersTurn(player2) == true
            @@player1_flag = true
            checkResult(@@moves, player1, player2)
          end
        end
      end       
    else
      puts "Game mode selected: Human vs Computer"
      player1 = Player.new
      player1.setMark = "X"
      comp = Computer.new
      comp.setMark = "O"
      player1.showPlrInfo
      comp.showPlrInfo
    
      while (@@moves.include?(" ") && end_game == false) do
        if (@@player1_flag == true && end_game == false)
          if playersTurn(player1) == true
            @@player1_flag = false
            checkResult(@@moves, player1, player2)
          end
        elsif (@@player1_flag == false && end_game == false)
          computersTurn(comp)
            @@player1_flag = true
            checkResult(@@moves, player1, comp)
        end
      end       
    end
  end

  def chooseTypeOfPlay
    puts "Select game mode:"
    puts "1. Play with friend"
    puts "2. Play against Computer"
    print "\nEnter a number (1 or 2) to select game mode:  "
    @@choice = gets.chomp.to_i
    until @@choice == 1 || @@choice == 2 do
      puts "#### Wrong input. Enter a number (1 or 2) to select game mode"
      @@choice = gets.chomp.to_i
    end
      
    case @@choice
    when 1
      return 1
    when 2
      return 2       
    end
  end

  def drawBoard
    puts ""
    puts "   #{@@moves[0]}  |  #{@@moves[1]}  |  #{@@moves[2]}   "
    puts "______|_____|______"
    puts "      |     |      "
    puts "   #{@@moves[3]}  |  #{@@moves[4]}  |  #{@@moves[5]}   "
    puts "______|_____|______"
    puts "      |     |      "
    puts "   #{@@moves[6]}  |  #{@@moves[7]}  |  #{@@moves[8]}   "
    puts ""
  end

  def updateBoard(mark, player)
    @@moves[mark] = player.getMark
    self.drawBoard
  end
  
  def playersTurn(p)
    puts "\n\nIt's  #{p.name}'s turn:"
    move = gets.chomp.to_i - 1

    if (@@moves[move] != " " || move == -1)
      puts "##### Wrong input, try again #####"
      return false
    else
      self.updateBoard(move, p)
      return true
    end
  end

  def computersTurn(computer)
    puts "\n\nIt's #{computer.name}'s turn."
    sleep 2
    comp_move = ""
    comp_move = computer.computerPlay(@@moves)
    while (@@moves[comp_move] != " ")
      comp_move = computer.computerPlay(@@moves)
    end
    puts "\n#{computer.name} played #{comp_move + 1}"
    self.updateBoard(comp_move, computer)
  end

  def checkResult(moves, plr1, plr2)
    if (moves[0] == moves[1] && moves[0] == moves[2] && moves[0] != " ")
      declareWinner(moves[0], plr1, plr2)
      self.end_game = (true)
    elsif (moves[3] == moves[4] && moves[3] == moves[5] && moves[3] != " ")
      declareWinner(moves[3], plr1, plr2)
      self.end_game = (true)
    elsif (moves[6] == moves[7] && moves[6] == moves[8] && moves[6] != " ")
      declareWinner(moves[6], plr1, plr2)
      self.end_game = (true)
    elsif (moves[0] == moves[3] && moves[0] == moves[6] && moves[0] != " ")
      declareWinner(moves[0], plr1, plr2)
      self.end_game = (true)
    elsif (moves[1] == moves[4] && moves[1] == moves[7] && moves[1] != " ")
      declareWinner(moves[1], plr1, plr2)
      self.end_game = (true)
    elsif (moves[2] == moves[5] && moves[2] == moves[8] && moves[2] != " ")
      declareWinner(moves[2], plr1, plr2)
      self.end_game = (true)
    elsif (moves[0] == moves[4] && moves[0] == moves[8] && moves[0] != " ")
      declareWinner(moves[0], plr1, plr2)
      self.end_game = (true)
    elsif (moves[2] == moves[4] && moves[2] == moves[6] && moves[2] != " ")
      declareWinner(moves[2], plr1, plr2)
      self.end_game = (true)
    elsif (moves.include?(" ") == false)
      puts "#######  Game over! --> DRAW  #######"
    end
  end

  def declareWinner(player_mark, p1, p2)
    case player_mark
    when "X"
      puts "######  Game over! --> #{p1.name} wins!  ######"
    when "O"
      puts "######  Game over! --> #{p2.name} wins!  ######"  
    end
  end
end

def startGame
  game = TicTacToe.new
  game.gameExplanation
  game.startPlay
  while game.newGame? == true do
    game.newGame?
  end
end

startGame

