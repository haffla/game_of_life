class Game
  attr_accessor :cells

  def initialize(cells)
    @width = cells.first.size
    @height = cells.size
    @cells = cells
  end

  def self.from(input, alive_char:)
    cells = input.split("\n").map { |line| line.split('').map { |char| char == alive_char } }
    new(cells)
  end

  def evolve
    new_gen = cells.map(&:dup)

    cells.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        new_gen[y][x] = determine_new_state(cell, x, y)
      end
    end

    self.cells = new_gen
  end

  def determine_new_state(cell, x, y)
    case [cell, n_alive_neighbours_for(x, y)]
    in [true, 2] | [true, 3] | [false, 3]
      true
    else
      false
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
      y_coord >= 0 && y_coord < @height && x_coord >= 0 && x_coord < @width && cells[y_coord][x_coord]
    end
  end

end
