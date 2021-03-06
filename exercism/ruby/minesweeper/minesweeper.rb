class ValueError < ArgumentError; end

class Board
  MINE = '*'.freeze
  LAND = ' '.freeze
  BORDER = '|'.freeze

  def self.transform(input)
    new(input).transform
  end

  def initialize(input)
    @input = input
    @width = @input[0].length
    @height = @input.length

    raise ValueError unless valid_input?
  end

  def transform
    locations
      .select { |loc| self[loc].marker == LAND && mines(loc) > 0 }
      .each { |loc| self[loc].marker = mines(loc) }

    grid.map { |row| row.map(&:marker).join }
  end

  private

  def grid
    @grid ||=
      @input.map(&:chars)
            .map { |row| row.map { |marker| Marker.new(marker) } }
  end

  Marker = Struct.new(:marker)

  def locations
    @locations ||=
      (0...@width).to_a.product((0...@height).to_a)
  end

  def [](location)
    x, y = location
    return nil if x < 0 || x >= @width
    return nil if y < 0 || y >= @height
    grid[y][x]
  end

  def mines(location)
    neighbors(location)
      .select { |neighbor| self[neighbor].marker == MINE }
      .count
  end

  def neighbors(location)
    x, y = location
    (x - 1..x + 1).to_a.product((y - 1..y + 1).to_a)
  end

  def valid_input?
    @input[1...-1].all? do |row|
      row.length == @width &&
        row[0] == BORDER && row[-1] == BORDER &&
        row[1...-1].chars.all? do |char|
          [' ', '*'].include?(char)
        end
    end
  end
end
