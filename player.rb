class Player
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def guess
    print 'Enter a letter: '
    letter = gets.chomp.downcase
    letter
  end

  def alert_invalid_guess
    puts 'The letter you chose was not valid'
  end
end
