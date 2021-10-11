class Ui
  ALIVE_CHAR = '#'.freeze
  DEAD_CHAR = '.'.freeze

  class << self
    def draw(game)
      loop do
        system 'clear'
        puts "############### Conway's Game of Life ###############"
        puts as_string(game)
        puts '#####################################################'
        game.evolve
        sleep 0.5
      end
    end

    def as_string(game)
      game.cells.map do |row|
        row.map do |alive|
          alive ? ALIVE_CHAR : DEAD_CHAR
        end.join
      end.join("\n")
    end
  end
end
