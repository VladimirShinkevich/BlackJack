# frozen_string_literal: true

class Game
  private

  attr_accessor :user, :diler, :deck
  attr_reader :interface

  public

  def initialize(user, diler, interface)
    @user = user
    @diler = diler
    @interface = interface
    @deck = Deck.new
  end

  def menu
    @interface.menu
    start_game
  end

  def start_game
    deal_cards
    make_bet
    @interface.start_data(@user, @diler)
    game
  end

  private

  def game
    loop do
      system('cls')
      if full_hand?
        @interface.open_cards(@user, @diler)
        game_over
      else
        @interface.show_cards(@user, @diler)
        @interface.show_action(@user)
        choose = gets.chomp.to_i
        case choose
        when 1 then skip_turn
        when 2 then add_card
        when 3
          @interface.open_cards(@user, @diler)
          game_over
        when 4
          @interface.goob_by
          sleep 2
          exit
        end
      end
    end
  end

  # новая игра
  def next_game
    @interface.keep_playing
    choose = gets.chomp.to_i
    case choose
    when 1 then start_game
    when 2
      @interface.goob_by
      sleep 2
      exit
    end
  end

  # пропустить ход, ход передается дилеру
  def skip_turn
    if @diler.hand.cards.size >= 3
      @interface.diler_turn
      sleep 2
      game
    else
      @diler.hand.take_card(@deck)
    end
  end

  # взять карту, для игрока
  def add_card
    @user.hand.take_card(@deck)
    if @user.hand.cards.size >= 3
      @interface.open_cards(@user, @diler)
      game_over
    end
  end

  # раздать карты
  def deal_cards
    2.times { @user.hand.take_card(@deck) }
    2.times { @diler.hand.take_card(@deck) }
    @diler.hand.take_card(@deck) if @diler.hand.points < 17
  end

  def make_bet
    @user.bet
    @diler.bet
  end

  # победа
  def win
    @user.get_steak(Player.class_variable_get(:@@steak))
    Player.class_variable_set :@@steak, 0
  end

  # поражение
  def lose
    @diler.get_steak(Player.class_variable_get(:@@steak))
    Player.class_variable_set :@@steak, 0
  end

  # ничья
  def draw
    @user.bank += 10
    @diler.bank += 10
    Player.class_variable_set :@@steak, 0
  end

  def full_hand?
    if @user.hand.cards.size == 3 && @diler.hand.cards.size == 3
      true
    else
      false
    end
  end

  # очистить стол
  def clear_table
    @user.hand.cards = []
    @diler.hand.cards = []
    @deck = Deck.new
  end

  # конец игры
  def game_over
    if @user.hand.points <= 21 && @user.hand.points > @diler.hand.points
      win
      @interface.win_text
    elsif @user.hand.points > 21
      lose
      @interface.lose_text
    elsif @diler.hand.points <= 21 && @diler.hand.points > @user.hand.points
      lose
      @interface.lose_text
    elsif @diler.hand.points > 21
      win
      @interface.win_text
    else
      draw
      @interface.draw_text
    end
    puts '##############################'
    puts ''
    clear_table
    next_game
  end
end
