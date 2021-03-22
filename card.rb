# frozen_string_literal: true

class Card
  attr_accessor :value, :suit

  VALUE = %w[A K Q J 10 9 8 7 6 5 4 3 2].freeze
  SUIT = %w[+ <3 ^ <>].freeze

  def initialize(value, suit)
    @suit = suit
    @value = value
  end

  def to_s
    "#{value} #{suit}"
  end
end
