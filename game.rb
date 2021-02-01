require './dictionary.rb'
require './player.rb'

class Game
  DICTIONARY_FILE_PATH = 'dictionary.txt'

  def initialize(*player_names)
    @dictionary = Dictionary.new(DICTIONARY_FILE_PATH)
    @players = player_names.map { |player_name| Player.new(player_name) }
    @losses = @players.reduce({}) { |hash, player| hash.merge({ player => 0 }) }
    @fragment = ''
    @round = 1
  end

  def next_player!
    player_that_just_completed_turn = @players.shift
    new_order_of_players = @players.push(player_that_just_completed_turn)
    @players = new_order_of_players
  end

  def current_player
    @players[0]
  end

  def previous_player
    @players[-1]
  end

  def valid_play?(guess)
    return false if !guess.kind_of?(String) || guess.length != 1
    to_be_word = @fragment + guess
    @dictionary.words_start_with?(to_be_word)
  end

  def take_turn(player)
    loop do
      player_guess = player.guess
      if self.valid_play?(player_guess)
        @fragment += player_guess
        break
      else
        player.alert_invalid_guess
      end
    end
  end

  def game_over?
    @dictionary.include?(@fragment)
  end

  def display_record(num_losses)
    game_record = 'GHOST'
    if num_losses == 0
      return ''
    else
      return game_record.slice(0, num_losses)
    end
  end

  def display_losses
    puts '-' * 30
    puts 'Current Losses'
    @losses.each do |player, num_losses|
      record_str = self.display_record(num_losses)
      player_str = player.name.ljust(15)
      puts player_str + ' | ' + record_str
    end
    puts '-' * 30
  end

  def record_loss(player)
    @losses[player] += 1
    @players.delete(player) if @losses[player] == 5
  end

  def conclude_round(losing_player)
    puts "#{losing_player.name} has lost the game"
    self.record_loss(losing_player)
    puts "Word: #{@fragment}"
    self.display_losses
    @fragment = ''
  end

  def play_round
    loop do
      current_player = self.current_player
      puts "It is #{current_player.name}'s turn"
      if @fragment.empty?
        puts 'Start the game with the first letter'
      else
        puts "Current fragment: #{@fragment}"
      end
      self.take_turn(current_player)
      break if self.game_over?
      self.next_player!
    end
    self.conclude_round(current_player)
  end

  def run
    until @players.size == 1
      puts '-' * 30
      puts "Round #{@round}".center(30)
      puts ''
      self.play_round
      @round += 1
    end
    winner = @players[0]
    puts "#{winner.name} has won!!!"
  end
end
