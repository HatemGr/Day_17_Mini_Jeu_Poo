require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

# -- Initialisation de la partie :
puts "Quell est ton nom de guerrier ?"
print "->"
name_input = gets.chomp
new_game = Game.new(HumanPlayer.new(name_input))
# -- Affichage de la bannière
new_game.header_display

while new_game.still_on_going?
  new_game.round_board
  new_game.new_player_in_sight
  new_game.show_players
  new_game.menu_display()
  player_choice = ""
  until new_game.menu_choice(player_choice)
    print "->"
    player_choice = gets.chomp
  end
  new_game.spacer
  new_game.ennemies_attack()
  #new_game.show_players
end

new_game.game_over()