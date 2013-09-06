class Deck
 
SUITS = ['♠', '♣', '♥', '♦']
VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
 
  def initialize
    build_deck
    shuffle
  end
 
  def build_deck
    @cards = []
    SUITS.each do |suit|
      VALUES.each do |value|
        @cards.push(Card.new(value, suit))
      end
    end
  end
 
  def pop
    @cards.pop
    # @cards.rotate.last
  end
 
  def shuffle
    @cards.shuffle!
  end
end

## End of Deck class
 
class Card
  attr_reader :suit, :value
 
  def initialize(value, suit)
    @suit = suit
    @value = value
  end
 
  def num_value
    if value == "A"
      1
    elsif /[KQJ]/.match(value)
      10
    else
      value.to_i
    end
  end
end

## End of Card class 

class Hand
 
  def initialize(name)
     @cards = []
     @name = name
     @turn = true
  end
 
  def hit(card)
    @cards << card
#change print @cards !!!!!!!!!
    print @cards
#change print @cards !!!!!!!!!    
  end
 
  def stand
    @turn = false
  end
 
  def score
    total = 0
    @cards.each do |card| 
      value = card.num_value
      if card.num_value == 1 && total <= 10
       value = 11
      end
      total += value
    end
    total
  end
 
  def busted?
    score > 21 
  end

  def is_turn?
    @turn 
  end
end

## End of Hand class 

class Game
 
  def initialize
    @deck = Deck.new
    @dealer_hand = Hand.new("dealer")
    @player_hand = Hand.new("player")
  end

  def run
    2.times { @player_hand.hit(@deck.pop)}

    # while it is still the players turn
    while @player_hand.is_turn?
      puts "players score #{@player_hand.score}"
      puts "Would you like to hit or stand?" 
      input = gets.chomp
      if input == "hit"
        @player_hand.hit(@deck.pop)
        if @player_hand.busted?
          puts "you lose"
          return
        end
      elsif input == "stand"
        @player_hand.stand
      else 
        puts "invalid input"
      end
    end

    2.times { @dealer_hand.hit(@deck.pop)}
    while @dealer_hand.score < 17
      @dealer_hand.hit(@deck.pop)
    end

    if @dealer_hand.busted?
      puts "player wins"
    elsif @dealer_hand.score > @player_hand.score
      puts "player loses"
    elsif @dealer_hand.score == @player_hand.score
      puts "tie"
    else
      puts "player wins"
    end
  end
end

## End of Game class

game = Game.new
game.run
