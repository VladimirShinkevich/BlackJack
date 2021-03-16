# frozen_string_literal: true

require_relative 'card'

class Player
  attr_accessor :bank, :steak, :hand, :point

  @@steak = 0

  def initialize
    @hand = []
    @bank = 100
    @point = 0
  end

  def take_card(card)
    @hand << card.give_card
  end

  def bet
    if @bank >= 10
      @bank -= 10
      @@steak += 10
    else
      puts 'У вас нехватает денег для ставки'
    end
  end

  def get_steak(prize)
    @bank += prize
  end

  def points
    @point = 0
    @hand.each do |card|
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
