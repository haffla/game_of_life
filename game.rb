class Board
  ALIVE_CHAR = 'o'.freeze
  DEAD_CHAR = '_'.freeze

  def initialize(cells)
    @width = cells.first.size
    @height = cells.size
    @cells = cells
  end

  def make_next_generation
    new_gen = @cells.map(&:dup)

    @cells.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        new_gen[y][x] = determine_new_state(cell, x, y)
      end
    end

    @cells = new_gen
  end

  def determine_new_state(cell, x, y)
    case [cell, n_alive_neighbours_for(x, y)]
    in [ALIVE_CHAR, 2] | [ALIVE_CHAR, 3] | [DEAD_CHAR, 3]
      ALIVE_CHAR
    else
      DEAD_CHAR
    end
  end

  def n_alive_neighbours_for(x, y)
    coords = [
      [y - 1, x - 1],
      [y - 1, x],
      [y - 1, x + 1],
      [y, x - 1],
      [y, x + 1],
      [y + 1, x - 1],
      [y + 1, x],
      [y + 1, x + 1]
    ]

    coords.count do |y_coord, x_coord|
      y_coord >= 0 && y_coord < @height && x_coord >= 0 && x_coord < @width &&
        @cells[y_coord][x_coord] == ALIVE_CHAR
    end
  end

  def as_string
    @cells.map(&:join).join("\n")
  end
end

cells = if ARGV.empty?
          File.read('./inputs/beacon.txt')
        else
          File.read(ARGV.first)
        end

cells = cells.split("\n").map { |line| line.split('') }
board = Board.new(cells)

loop do
  system 'clear'
  puts board.as_string
  board.make_next_generation
  sleep 0.5
end
