# PHASE 2
# returning a suitable replacement when error occurs
def convert_to_int(str)
  begin
    num = Integer(str)
  rescue ArgumentError  # be specific to which error to handle
    puts "Invalid input."
  ensure
    num ||= nil  # ensures to output nil if not valid
  end
  
  num
end

# PHASE 3
# .freeze -> makes constant FRUITS immutable
# letting user retry input for certain errors
FRUITS = ["apple", "banana", "orange"].freeze

# inherit StandardError to be used as a custom error
class CoffeeError < StandardError
  def message
    "I can't have any more caffeine."
  end
end

class NotAFruitError < StandardError
  def message
    "That doesn't look like a fruit."
  end
end

def reaction(maybe_fruit)
  if FRUITS.include?(maybe_fruit)
    puts "OMG, thanks so much for the #{maybe_fruit}!"
  elsif maybe_fruit == 'coffee' 
    raise CoffeeError
  else
    raise NotAFruitError
  end 
end

def feed_me_a_fruit
  puts "Hello, I am a friendly monster. :)"

  begin
    puts "Feed me a fruit! (Enter the name of a fruit:)"
    maybe_fruit = gets.chomp
    reaction(maybe_fruit)
  rescue CoffeeError => e  # initialize CoffeeError to e
    puts e.message  # call message method
    retry  # goes back to begin
  rescue NotAFruitError => e
    puts e.message
  end
end

# PHASE 4
# enforcing correct usage of code
class LessThanFiveYears < StandardError
  def message
    puts "We need to be friends for at least 5 years to be considered best friends."
  end
end

class BestFriend
  def initialize(name, yrs_known, fav_pastime)
    raise ArgumentError.new("'name' cannot be blank") if name.empty?
    raise ArgumentError.new("'yrs_known' must be greater than or equal to 5") if yrs_known.to_i < 5
    raise ArgumentError.new("'fav_pasttime' cannot be blank") if fav_pastime.empty?

    @name = name
    @yrs_known = yrs_known.to_i
    @fav_pastime = fav_pastime
  end

  def talk_about_friendship
    puts "Wowza, we've been friends for #{@yrs_known}. Let's be friends for another #{1000 * @yrs_known}."
  end

  def do_friendstuff
    puts "Hey bestie, let's go #{@fav_pastime}. Wait, why don't you choose. 😄"
  end

  def give_friendship_bracelet
    puts "Hey bestie, I made you a friendship bracelet. It says my name, #{@name}, so you never forget me." 
  end
end

if __FILE__ == $PROGRAM_NAME
  # PHASE 2 test cases
  puts convert_to_int("5a7")
  puts convert_to_int("392")

  # PHASE 3
  feed_me_a_fruit

  # PHASE 4 is tested in user_script.rb
end

