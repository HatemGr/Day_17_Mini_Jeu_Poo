
class Game
  attr_accessor :human_player, :ennemies
  @@name_list = ["Raisin Sec", "Tarte Citron","Les Nuages","Le Kouglof","Fruits Confits","Le Metro","La Pluie","Le Froid","Mon Reveil","La Country","La Meringue","Les Maladies","La Guerre","Raisin Sec 2"]
  @@name_list_index = 0
  
  def initialize(human_player)
    @human_player = human_player
    @enemies_left = 10
    #@enemies_in_sight = [*0..3].map {|i| Player.new(@@name_list[i]) }
    @enemies_in_sight = []
    @round_number = 1
  end

  def kill_player(player)
    @enemies_in_sight.delete(player)
  end

  def still_on_going?
    return @human_player.is_alive? && (@enemies_in_sight.size > 0 || @enemies_left > 0)
  end

  def new_name
    name = @@name_list[@@name_list_index]
    @@name_list_index += 1
    return name
  end

  def new_player_in_sight
    if @enemies_left > 0
      dice = rand(1..6).to_s
      case dice
      when "1"
        puts "Pas de nouvel adversaire en vue..."
      when /[234]/
        #new_enemy_name = "Player_#{rand(100.999)}"
        new_enemy_name = self.new_name
        @enemies_in_sight << Player.new(new_enemy_name)
        @enemies_left -=1
        puts "#{new_enemy_name} s'approche pour vous attaquer !"
      else
        #new_enemy_name_1 = "Player_#{rand(100.999)}"
        new_enemy_name_1 = self.new_name
        @enemies_in_sight << Player.new(new_enemy_name_1)
        @enemies_left -=1
        if @enemies_left > 0
          #new_enemy_name_2 = "Player_#{rand(100.999)}"
          new_enemy_name_2 = self.new_name
          @enemies_in_sight << Player.new(new_enemy_name_2)
          @enemies_left -=1
          puts "#{new_enemy_name_1} et #{new_enemy_name_2} s'approchent pour vous attaquer !"
        else
          puts "#{new_enemy_name_1} s'approche pour vous attaquer !"
        end
          
      end
    end
    self.spacer
  end

  def show_players
    @human_player.show_state
    puts "Il a #{@enemies_in_sight.size} ennemis en face de vous."
    puts "#{@enemies_left} ennemies vous regardent de loin"
    puts " "
  end

  def header_display
    puts "--------------------------------------------------"
    puts "|    Bienvenue sur 'ILS VEULENT TOUS MA POO' !   | "
    puts "| Le but du jeu est d'être le dernier survivant !| "
    puts "---------------------------------------------------"
    puts " "
    puts "Bienvenu à toi #{human_player.name}, tu viens ici combattre #{@enemies_left} ennemis redoutables !"
    puts "Prepare toi ! Ils arrivent !"
  end

  def round_board
    puts " "
    puts "######################  ROUND #{@round_number}  ######################"
    puts " "
    @round_number += 1
  end

  def menu_display
    puts "Quelle action veux-tu effectuer ?"
    puts "a - chercher une meilleure arme"
    puts "s - chercher à se soigner "
    puts "attaquer un joueur en vue :"
    @enemies_in_sight.each.with_index {|enemy,i| puts "#{i} - #{enemy.name} a #{enemy.life_points} PV."}
  end

  def spacer
    puts "- " * 25
  end

  def menu_choice(str)
    puts " "
    case str
    when "a"
      human_player.search_weapon()
      return true
    when "s"
      human_player.search_health_pack()
      return true
    when /\b\d{1}\b/
      nbr = str.to_i
      if nbr >= @enemies_in_sight.size
        puts "Il n'y a pas autant d'ennemi !"
        return false
        elsif @enemies_in_sight[nbr].life_points > 0 
        human_player.attacks(@enemies_in_sight[nbr])
        if @enemies_in_sight[nbr].life_points <= 0
          kill_player(@enemies_in_sight[nbr])
        end
        return true
      end
    else  
      puts "Faire un choix parmis les options:"
      return false
    end
  end

  def ennemies_attack
    @enemies_in_sight.each {|enemy| enemy.attacks(human_player) ; self.spacer}
  end

  def game_over
    human_player.is_alive? ? (puts "Felicitation, tu as gagné !") : (puts "Tu es mort, tu as perdu.")
  end

end