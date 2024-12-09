require 'yaml'

sample_data1 = YAML.load_file('data.yml')['sample_data1']
sample_data2 = YAML.load_file('data.yml')['sample_data2']

def build_locations_hash(grid)
  hash = {}

  grid.each_with_index do |line, ri|
    line.each_char.with_index do |c, ci|
      hash[c] = hash.fetch(c, []) << [ri, ci] if c.match?(/\d+|[a-z]|[A-Z]/)
    end
  end

  hash
end

def valid_position?(coordinate, grid)
  row, col = coordinate

  p "row: #{row}"
  p "col: #{col}"

  row >= 0 && col >= 0 && row < grid.length && col < grid[0].length
end

def part1(data)
  grid = data.split(/\n/)
  locations = build_locations_hash(grid)
  antinodes = Set.new

  locations.each_value do |location_arr|
    location_arr.each do |p1|
      location_arr.each do |p2|
        next if p1 == p2

        delta = [p2[0] - p1[0], p2[1] - p1[1]]
        row_delta, col_delta = delta

        curr_row_delta = row_delta
        curr_col_delta = col_delta
        while valid_position?([p1[0] - curr_row_delta, p1[1] - curr_col_delta], grid)
          an1 = [p1[0] - curr_row_delta, p1[1] - curr_col_delta]

          antinodes.add(an1)

          curr_row_delta += row_delta
          curr_col_delta += col_delta
        end

        curr_row_delta = row_delta
        curr_col_delta = col_delta
        while valid_position?([p1[0] + curr_row_delta, p1[1] + curr_col_delta], grid)
          an2 = [p1[0] + curr_row_delta, p1[1] + curr_col_delta]

          antinodes.add(an2)

          curr_row_delta += row_delta
          curr_col_delta += col_delta
        end
      end
    end
  end

  antinodes.length
end

# p part1(sample_data1)
p part1(sample_data2)

# ##....#....#
# .#.#....0...
# ..#.#0....#.
# ..##...0....
# ....0....#..
# .#...#A....#
# ...#..#.....
# #....#.#....
# ..#.....A...
# ....#....A..
# .#........#.
# ...#......##
#
# ##....#....#
# .#.#....0...
# ..M.#0....#.
# ..#M...0....
# ....#....#..
# .#...##....#
# ...#..#.....
# #....#.#....
# ..#.....A...
# ....#....A..
# .#........#.
# ...#......##

# 0's:
# [1
# [2, 5]
# => [-1, 3]  (take the distance between the two points)
# ==> [-2, 6] (double it)
# Use the original point to determine where the doubled distance puts you
# [1, 8]
# [-2, 6]
# [3, 2] =>   (3, 2) is a valid position, so we put an antinode there
#
# [1, 8]
# [3, 7]
# => [-2, 1]
#
# [1, 8]
# [4, 4]
# => [-3, 4]
#
#
# [3, 7]
# [4, 4]
# A's:
# [5, 7]
# [8, 9]
# [9, 10]

# Iterate through the grid
# Get all the antenna locations
# Iterate through the antenna locations
# => For each antenna, calculate the distance between it and all the other antennas of that particular letter or digit
# => Double the distance between the two antennas
# => Use the original point to determine what index positions the doubling would result in
# => If it's a valid index position that doesn't already have an antinode, place an antinode there
# => Use a cache strategy to avoid doing double checking
# ===> Cache will be the index of the antinode as the key and either the two antennas or true as value

# {"0"=>[[1, 8], [2, 5], [3, 7], [4, 4]], "A"=>[[5, 6], [8, 8], [9, 9]]}
