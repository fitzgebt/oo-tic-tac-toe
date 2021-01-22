require 'pry'



class TicTacToe

    # Instance Variables and Constants
    @board
    @last_user_input
    WIN_COMBINATIONS = [
        [6,7,8],  #Top row
        [3,4,5],  #Middle row
        [0,1,2],  #Bottom row
        [0,3,6],  #Left column
        [1,4,7],  #Middle column
        [2,5,8],  #Right column
        [2,4,6],  #Top Left to Bottom Right
        [0,4,8]  #Top Right to Bottom Left
    ]

    def initialize
        @board = [" "," "," "," "," "," "," "," "," "]
    end

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} \n-----------\n #{@board[3]} | #{@board[4]} | #{@board[5]} \n-----------\n #{@board[6]} | #{@board[7]} | #{@board[8]} \n"
    end

    def input_to_index(input)
        @last_user_input = input.to_i - 1
    end

    def move(user_input, value = "X")
        @board[user_input] = value
    end

    def position_taken?(index)
        if @board[index]  == " " || @board[index] == ""
            false
            elsif @board[index] == "X" || @board[index] == "x" || @board[index] == "O" || @board[index] == "o"
            true
            elsif @board[index] == nil
            false
        end
    end

    def valid_move?(index)
        if position_taken?(index) == false && index.between?(0,8)
            true
        else
            false
        end
    end

    def turn_count
        @board.count("X") + @board.count("O")
    end

    def current_player
        turn_count.even? ? "X" : "O"
    end

    def turn
        puts "Plesae choose a position"             # ask for input
        input = gets                                # get input
        index = input_to_index(input)               # translate input into index
        if valid_move?(index) == true               # if index is valid
            move(index, current_player)             #     make the move for index
            display_board                           #     show the board
        else                                        # else
            turn                                    #     restart turn
        end                                         # end 
    end

    def won?
        WIN_COMBINATIONS.each do |win|
            a = win[0]
            b = win[1]
            c = win[2]
            if @board[a] == "X" && @board[b] == "X" && @board[c] == "X"
                return win.to_a
            elsif @board[a] == "O" && @board[b] == "O" && @board[c] == "O"
                return win.to_a
            end
        end
        return false
    end

    def full?
        @board.each do |value|
            i = 0
            while i <= 8
                if @board[i] == "X" || @board[i] == "O"
                    i += 1                   
                elsif @board[i] == " "
                    return false
                end
            end
        end
    end

    def draw?
        full? && !won?
        # full? == true && won? == false ? true : false
    end

    def over?
        won? || draw?
    end

    def winner
        # won? ? !current_player : false
        if won?
            if turn_count.odd?
                return "X"
            else
                return "O"
            end
        end
    end

    def play
        turn until over?
        if won?
            puts "Congratulations #{winner}!"
        elsif draw?
            puts "Cat's Game!"
        end
    end
end