require './game'

cells = if ARGV.empty?
          File.read('./inputs/beacon.txt')
        else
          File.read(ARGV.first)
        end

cells = cells.split("\n").map { |line| line.split('') }
game = Game.new(cells)

loop do
  system 'clear'
  puts game.as_string
  game.evolve
  sleep 0.5
end
