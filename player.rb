# frozen_string_literal: true

require_relative 'hand'

class Player
  attr_accessor :bank, :steak, :hand

  @@steak = 0

  def initialize
    @hand = Hand.new
    @bank = 100
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
end
