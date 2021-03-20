# frozen_string_literal: true

require_relative 'deck'

class Hand
  attr_accessor :cards
  attr_reader :point

  def initialize
    @cards = []
    @point = 0
  end

  def take_card(deck)
    @cards << deck.give_card
  end

  def points
    @point = 0
    @cards.each do |card|
      name = card.split(' ')
      index = name[0]
      case index
      when 'K' then @point += 10
      when 'Q' then @point += 10
      when 'J' then @point += 10
      when 'A'
        @point += 11 if @point + 11 < 21
        @point += 1 if @point + 1 > 21
      else
        @point += index.to_i
      end
    end
    @point
  end
end
