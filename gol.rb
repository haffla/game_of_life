require './game'

cells = if ARGV.empty?
          File.read('./inputs/mwss.txt')
        else
          File.read(ARGV.first)
        end

cells = cells.split("\n").map { |line| line.split('') }
game = Game.new(cells)

loop do
  system 'clear'
  puts "############### Conway's Game of Life ###############"
  puts game.as_string
  puts '#####################################################'
  game.evolve
  sleep 0.5
end
