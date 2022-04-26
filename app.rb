# lignes qui appellent les gems du Gemfile
require 'bundler'
Bundler.require

require_relative "lib/game"
require_relative "lib/player"

# -- Creation des béligérants
player1 = Player.new("Josiane")
player2 = Player.new("José")

while player1.life_points > 0 && player2.life_points > 0
  puts "-" * 50
  puts "Voici l'état de chaque joueur :"
  player1.show_state
  player2.show_state
  puts "-  -  -  -  -  -  -  -  -  -  -  -  -"
  player1.attacks(player2)
  puts ""
  player2.life_points <= 0 ? break : player2.attacks(player1)  
end

winner = Player.all.select {|player| player.life_points > 0}.first
puts "#{winner.name} a gagné la bataille !"

playerh = HumanPlayer.new("Grey Hat")
binding.pry