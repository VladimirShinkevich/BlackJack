# frozen_string_literal: true

require_relative 'card'
require_relative 'diler'
require_relative 'interface'
require_relative 'player'
require_relative 'user'
require_relative 'deck'
require_relative 'hand'
require_relative 'game'

class Blackjack
  def initialize
    @user = User.new
    @diler = Diler.new
    @interface = Interface.new
    @game = Game.new(@user, @diler, @interface)
  end

  def start_blackjack
    @game.menu
  end
end

blackjack = Blackjack.new
blackjack.start_blackjack
