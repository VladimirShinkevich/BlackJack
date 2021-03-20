# frozen_string_literal: true

require_relative 'card'

class Deck
  attr_reader :deck

  def initialize
    @deck = []
    create_deck
  end

  def give_card
    take_card = @deck[rand(@deck.size)]
    @deck.delete(take_card)
  end

  def create_deck
    Card::VOLUE.each do |vol|
      @deck << "#{vol} #{Card::SUIT[0]}"
      @deck << "#{vol} #{Card::SUIT[1]}"
      @deck << "#{vol} #{Card::SUIT[2]}"
      @deck << "#{vol} #{Card::SUIT[3]}"
    end
  end
end
