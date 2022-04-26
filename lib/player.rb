
class Player
  
  attr_reader :name # --- Variables d'instance pouvant etre lues mais pas modifiées
  attr_accessor :life_points # --- Variables d'instance pouvant etre lues et modifiées
  @@player_list = []

  def initialize (name) # --- Methode initialisant le joueur
    @name = name
    @life_points = 10
    @@player_list << self
  end

  # --- METHODES D'INSTANCE
  def show_state
    puts "#{@name} a #{@life_points} points de vie."
  end

  def get_damages(damage)
    @life_points -= damage
    puts "Le joueur #{@name} a été tué !" if @life_points <= 0
    @life_points < 0 ? @life_points = 0 : @life_points
    
  end

  def attacks(ennemy)
    puts "#{@name} attaque le joueur #{ennemy.name}."
    damage = compute_damage()
    puts "Il lui inflige #{damage} points de dêgats."
    ennemy.get_damages(damage)
  end

  def is_alive?
    return @life_points > 0
  end

  # --- METHODES DE CLASSE
  def self.all
    return @@player_list
  end

  private # --- METHODES PRIVEES NON ACCESSIBLE A L'UTILISATEUR
  def compute_damage()
    return rand(1..6)
  end

end

################--------HUMAN PLAYER---------################

class HumanPlayer < Player
  attr_accessor :weapon_level

  def initialize(name)
    @name =name
    @weapon_level = 1
    @life_points = 100
  end

  def show_state()
    puts "#{name} a #{@life_points} points de vie et une arme de niveau #{weapon_level}"
  end

  def search_weapon ()
    new_weapon_level = rand(1..6)
    puts "Tu as trouvé une arme de niveau #{new_weapon_level}"
    if new_weapon_level > @weapon_level
      puts "Elle est meilleure que celle que tu as entre les mains, tu la prends !"
      @weapon_level = new_weapon_level
    else
      puts "Ton arme actuelle est meilleure, tu jetes cette arme !"
    end
  end

  def search_health_pack()
    dice = rand(1..6)
    if dice == 1
      puts "Tu n'as rien trouvé"
    elsif dice > 1 && dice < 6
      puts "Tu as trouvé un pack de +50 PV"
      @life_points = [100, @life_points + 50].min
      puts "Tu as maintenant #{@life_points} PV."
    else
      puts "Wow, tu as trouvé un pack de +80 PV"
      @life_points = [100, @life_points + 80].min
      puts "Tu as maintenant #{@life_points} PV."
    end
  end

  private

  def compute_damage()
    return rand(1..6) * @weapon_level
  end
end