# frozen_string_literal: true

require_relative 'card'

class Deck
  attr_reader :deck

  def initialize
    @card = []
    create_deck
  end

  def give_card
    take_card = @card[rand(@card.size)]
    @card.delete(take_card)
  end

  def create_deck
    Card::VALUE.each do |value|
      Card::SUIT.each do |suit|
        @card << Card.new(value, suit)
      end
    end
  end
end
