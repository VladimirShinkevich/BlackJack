# frozen_string_literal: true

class Card
  def initialize
    @pack = []
    create_pack
  end

  def give_card
    take_card = @pack[rand(@pack.size)]
    @pack.delete(take_card)
  end

  def create_pack
    card_name = %w[A K Q J 10 9 8 7 6 5 4 3 2]
    card_suit = %w[+ <3 ^ <>]
    card_name.each do |name|
      @pack << "#{name} #{card_suit[0]}"
      @pack << "#{name} #{card_suit[1]}"
      @pack << "#{name} #{card_suit[2]}"
      @pack << "#{name} #{card_suit[3]}"
    end
  end
end
