require './game'
require './ui'

input = if ARGV.empty?
          File.read('./inputs/mwss.txt')
        else
          File.read(ARGV.first)
        end

game = Game.from(input, alive_char: 'o')
Ui.draw(game)
