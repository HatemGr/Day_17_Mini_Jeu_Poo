require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

puts "------------------------------------------------"
puts "|   Bienvenue sur 'ILS VEULENT TOUS MA POO' !   |"
puts "|Le but du jeu est d'être le dernier survivant !|"
puts "-------------------------------------------------"
puts " "

#-- Initialisation du joueur en lui demandant son nom et creation d'une instance HumanPlayer
puts "Quell est ton nom de guerrier ?"
print "->"
name_input = gets.chomp
player = HumanPlayer.new(name_input)

#-- Initialisation des ennemis par deux instances de Players
ennemies = [ennemi_1 = Player.new("Josiane"), ennemi_2 = Player.new("José")]
round_number = 1

#-- Succession de rounds jusqu'a la victoire d'un des camps
while player.life_points > 0 && (ennemi_1.is_alive? || ennemi_2.is_alive?)
  puts ""
  puts "#"*20 + " -- ROUND #{round_number} -- " + "#"*20
  puts ""
  player.show_state
  puts "- " * 25
  
  puts "Quelle action veux-tu effectuer ?"
  puts "a - chercher une meilleure arme"
  puts "s - chercher à se soigner "
  puts "attaquer un joueur en vue :"
  ennemi_1.life_points > 0 ? (puts "0 - Josiane a #{ennemi_1.life_points} points de vie") : (puts "#{ennemi_1.name} est mort.")
  ennemi_2.life_points > 0 ? (puts "1- José a #{ennemi_2.life_points} points de vie") : (puts "#{ennemi_2.name} est mort.")
  next_round = false
  until next_round
    print " ->"
    player_choice = gets.chomp
    puts "- " * 25

    # -- Module switch pour gerer le choix du joueur
    case player_choice
    when "a"
      player.search_weapon()
      next_round = true
    when "s"
      player.search_health_pack()
      next_round = true
    when "0"
      if ennemi_1.life_points > 0 
        player.attacks(ennemi_1)
        next_round = true
      else 
        puts "#{ennemi_1.name} est déjà mort."
      end
    when "1"
      if ennemi_2.life_points > 0 
        player.attacks(ennemi_2)
        next_round = true
      else 
        puts "#{ennemi_2.name} est déjà mort."
        next_round = false
      end
    else
      puts "Choix non reconnu, choisir 'a', 's', '0' ou '1'"
      next_round = false
    end
    end
    puts ""
    ennemi_1.is_alive? || ennemi_2.is_alive? ? (puts "Les ennemis attaquent !") : (puts " ")
    ennemies.each do |ennemi|
      puts "- " * 25
      if player.is_alive?
        ennemi.is_alive? ? ennemi.attacks(player) : (puts "#{ennemi.name} est mort.")
      end
  end
  #Passage au round suivant
  round_number += 1
end

#Determination du vainqueur en sortant de la loop while
puts ""
player.is_alive? ? (puts "Tu as gagné la bataille !") : (puts "Tu as perdu la bataille...")
#binding.pry
