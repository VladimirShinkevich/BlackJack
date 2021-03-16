# frozen_string_literal: true

require_relative 'card'
require_relative 'diler'
require_relative 'interface'
require_relative 'player'
require_relative 'user'

class Game
  attr_reader :user, :card, :diler

  def initialize
    @user = User.new
    @diler = Diler.new
    @card = Card.new
  end

  def menu
    puts '##################################'
    puts '##      $$$ BlackJack $$$       ##'
    puts '##################################'
    puts START_MENU
    choose = gets.chomp.to_i
    case choose
    when 1 then user_data
    when 2
      puts RULES_GAME
      choose1 = gets.chomp.to_i
      case choose1
      when 1 then menu
      end
    end
  end

  def user_data
    print 'Введите ваше имя: '
    @user_name = gets.chomp.capitalize!
    start
  end

  def start
    puts "#{@user_name} ваш банк #{@user.bank} $"
    puts "Банк дилера: #{@diler.bank} $"
    deal_cards
    @user.bet
    @diler.bet
    puts 'Вы и Казино сделали ставки по 10 $'
    puts "На кону #{Player.class_variable_get :@@steak} $!!!"
    game
  end

  def game
    loop do
      open_cards if @user.hand.size == 3 || @diler.hand.size == 3
      show_cards
      puts "#{@user_name} ваш ход"
      puts 'Выберите действие'
      puts USER_TURN
      choose = gets.chomp.to_i
      case choose
      when 1 then skip_turn
      when 2 then add_card
      when 3 then open_cards
      when 4 then exit
      end
    end
  end

  def deal_cards
    2.times { @user.take_card(@card) }
    2.times { @diler.take_card(@card) }
    @diler.take_card(@card) if @diler.points < 17
  end

  def show_cards
    puts 'Ваши карты: '
    @user.hand.each { |user_card| puts user_card.to_s }
    puts 'Карты дилера: '
    @diler.hand.each { |_diler_card| puts ':)' }
  end

  def skip_turn
    @diler.take_card(@card)
  end

  def add_card
    @user.take_card(@card)
  end

  def open_cards
    puts '*******************************'
    puts 'Ваши карты: '
    @user.hand.each { |user_card| print "|#{user_card}| " }
    puts ''
    puts "Ваши очки: #{@user.points}"
    puts '*******************************'
    puts 'Карты дилера: '
    @diler.hand.each { |diler_card| print "|#{diler_card}| " }
    puts ''
    puts "Очки дилера: #{@diler.points}"
    puts '*******************************'
    game_over
  end

  def win
    @user.get_steak(Player.class_variable_get(:@@steak))
    Player.class_variable_set :@@steak, 0
  end

  def lose
    @diler.get_steak(Player.class_variable_get(:@@steak))
    Player.class_variable_set :@@steak, 0
  end

  def draw
    @user.bank += 10
    @diler.bank += 10
    Player.class_variable_set :@@steak, 0
  end

  def next_game
    puts 'Выберите действие'
    puts CONTINUE
    choose = gets.chomp.to_i
    case choose
    when 1 then start
    when 2 then exit
    end
  end

  def game_over
    if @user.points <= 21 && @user.points > @diler.points
      win
      puts 'Вы выиграли!!!'
    elsif @user.points > 21
      lose
      puts 'Вы проиграли!!!'
    elsif @diler.points <= 21 && @diler.points > @user.points
      lose
      puts 'Вы проиграли!!!'
    elsif @diler.points > 21
      win
      puts 'Вы выиграли!!!'
    else
      draw
      puts 'Ничья...'
      puts 'Игрокам возвращается по 10 $'
    end
    puts '##############################'
    puts ''
    clear_table
    next_game
  end

  def clear_table
    @user.hand = []
    @diler.hand = []
  end
end

blackjack = Game.new
blackjack.menu
