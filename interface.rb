# frozen_string_literal: true

class Interface
  attr_accessor :bank, :user_name

  START_MENU = %(
1. Начать игру
2. Правила
3. Выход)

  RULES_GAME = %(
 Сумма очков: от 2 до 10 - по номиналу карты,
 все «картинки» - по 10, туз - 1 или 11, в зависимости от того,
 какое значение будет ближе к 21 и что не ведет к проигрышу (сумме более 21).
 - Выигрывает игрок, у которого сумма очков ближе к 21
 - Если у игрока сумма очков больше 21, то он проиграл
 - Если сумма очков у игрока и дилера одинаковая, то объявляется ничья
   и деньги из банка возвращаются игрокам
 - Сумма из банка игры переходит к выигравшему
 ***************************************************
   Для выхода назад в меню нажмите 1)

  USER_TURN = %(
1. Пропустить ход
2. Добавить карту
3. Открыть карты
4. Выйти из игры)

  CONTINUE = %(
1. Продолжить игру
2. Выйти из игры)

  # стартовое меню
  def menu
    puts '##################################'
    puts '##      $$$ BlackJack $$$       ##'
    puts '##################################'
    puts START_MENU
    choise = gets.chomp.to_i
    case choise
    when 1 then user_data
    when 2
      puts RULES_GAME
      choise1 = gets.chomp.to_i
      case choose1
      when 1 then menu
      end
    when 3
      goob_by
      sleep 2
      exit
    end
  end

  # имя пользователя
  def user_data
    print 'Введите ваше имя: '
    @user_name = gets.chomp.capitalize!
    raise StandardError, 'Вы не ввели имя!!!' if @user_name.nil?
  rescue StandardError => e
    puts e.message
    retry
  end

  def start_data(user, diler)
    puts "#{@user_name} ваш банк #{user.bank} $"
    puts "Банк дилера: #{diler.bank} $"
    puts 'Вы и Казино сделали ставки по 10 $'
    puts "На кону #{Player.class_variable_get :@@steak} $!!!"
  end

  # показать карты
  def show_cards(user, diler)
    puts 'Ваши карты: '
    user.hand.cards.each { |user_card| puts user_card.to_s }
    puts 'Карты дилера: '
    diler.hand.cards.each { |_diler_card| puts '|X|' }
  end

  def diler_turn
    puts 'Дилер пропускает ход...'
    puts 'Вы снова ходите...'
  end

  # открыть все карты
  def open_cards(user, diler)
    system('cls')
    puts '*******************************'
    puts 'Ваши карты: '
    user.hand.cards.each { |user_card| print "|#{user_card}| " }
    puts ''
    puts "Ваши очки: #{user.hand.points}, ваш банк: #{user.bank} $"
    puts '*******************************'
    puts 'Карты дилера: '
    diler.hand.cards.each { |diler_card| print "|#{diler_card}| " }
    puts ''
    puts "Очки дилера: #{diler.hand.points}, банк дилера: #{diler.bank} $"
    puts '*******************************'
  end

  # новая игра
  def keep_playing
    puts 'Выберите действие'
    puts CONTINUE
    choise = gets.chomp.to_i
  end

  def show_action(user)
    puts "В банке: #{user.bank} $"
    puts "#{@user_name} ваш ход"
    puts 'Выберите действие'
    puts USER_TURN
    choise = gets.chomp.to_i
  end

  def goob_by
    puts 'До скорых встреч!!!'
  end

  def win_text
    puts 'Вы выиграли!!!'
  end

  def lose_text
    puts 'Вы проиграли!!!'
  end

  def draw_text
    puts 'Ничья...'
    puts 'Игрокам возвращается по 10 $'
  end

  def end_game_line
    puts '##############################'
    puts ''
  end
end
