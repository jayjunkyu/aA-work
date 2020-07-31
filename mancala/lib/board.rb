require 'byebug'

class Board
  attr_accessor :cups
  attr_reader :name1, :name2

  def initialize(name1, name2)
    @cups = []
    @name1 = name1
    @name2 = name2

    (0...14).each do |cup|
      if cup != 6 && cup != 13
        @cups << place_stones
      else
        @cups << []
      end
    end

  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    [:stone, :stone, :stone, :stone]
  end

  def valid_move?(start_pos)
    if 0 > start_pos || start_pos > 13 || start_pos == 6 || start_pos == 13
      raise "Invalid starting cup"
    end

    if @cups[start_pos].empty?
      raise "Starting cup is empty"
    end

    true
  end

  def make_move(start_pos, current_player_name)
    # debugger
    if valid_move?(start_pos)
      curr_stones = @cups[start_pos].count
      @cups[start_pos] = []
      
      curr_pos = start_pos + 1

      until curr_stones == 0
        curr_pos %= 14

        if curr_pos == 6 && current_player_name == name1
          @cups[curr_pos] << :stone
          curr_stones -= 1
        elsif curr_pos == 13 && current_player_name == name2
          @cups[curr_pos] << :stone
          curr_stones -= 1
        elsif curr_pos != 6 && curr_pos != 13
          @cups[curr_pos] << :stone
          curr_stones -= 1
        end
        
        curr_pos += 1
      end

    end

    render
  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
  end

  def winner
  end
end
