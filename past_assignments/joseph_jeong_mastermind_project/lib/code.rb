require "byebug"

class Code
  attr_reader :pegs

  POSSIBLE_PEGS = {
    "R" => :red,
    "G" => :green,
    "B" => :blue,
    "Y" => :yellow
  }

  def self.valid_pegs?(pegs)
    # debugger
    pegs.all? { |peg| POSSIBLE_PEGS.has_key?(peg.upcase) }
  end

  def initialize(pegs)
    if !self.class.valid_pegs?(pegs)
      raise "invalid combination"
    else
      new_pegs = pegs.map(&:upcase)
      @pegs = new_pegs
    end
  end

  def self.random(length)
    # debugger
    random_pegs = length.times.map { POSSIBLE_PEGS.keys.sample }
    Code.new(random_pegs)
  end

  def self.from_string(s)
    new_pegs = s.split('')
    Code.new(new_pegs)
  end

  def [](index)
    self.pegs[index]
  end

  def length
    self.pegs.length
  end

  def num_exact_matches(other_code)
    count = 0
    self.pegs.each.with_index do |peg, i|
      if other_code.pegs[i] == peg
        count += 1
      end
    end

    count
  end

  def num_near_matches(other_code)
    count = 0
    other_code.pegs.each.with_index do |peg, i|
      if self.pegs.include?(peg) && other_code.pegs[i] != self.pegs[i]
        count += 1
      end
    end
    count
  end

  def ==(other_code)
    # debugger
    self.pegs == other_code.pegs
  end
end
