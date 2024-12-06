require 'yaml'

sample_data2 = YAML.load_file('data.yml')['sample_data2']
sample_data1 = YAML.load_file('data.yml')['sample_data1']

def parse_data(data)
  data.split(/\n/)
end

def find_start(grid)
  grid.each_with_index { |r, ri| r.each_char.with_index { |char, ci| return [ri, ci] if char == '^' } }
end

def row_valid?(row, grid)
  row >= 0 && row < grid.length
end

def col_valid?(row, col, grid)
  col >= 0 && col < grid[row].length
end

def part1(data)
  grid = parse_data(data)
  directions = [[-1, 0], [0, 1], [1, 0], [0, -1]]

  row, col = find_start(grid)
  curr_dir_idx = 0
  curr_dir = directions[curr_dir_idx]
  moves = 0

  while row_valid?(row, grid) && col_valid?(row, col, grid)
    if grid[row + curr_dir[0]] && grid[row + curr_dir[0]][col + curr_dir[1]] == '#'
      curr_dir_idx = curr_dir_idx + 1 < directions.length ? curr_dir_idx + 1 : 0
      curr_dir = directions[curr_dir_idx]
    end

    if row_valid?(row, grid) && col_valid?(row, col, grid) && grid[row][col] != 'X'
      moves += 1
      grid[row][col] = 'X'
    end

    row += curr_dir[0]
    col += curr_dir[1]

  end

  moves
end

# p part1(sample_data1)
p part1(sample_data2)

# Given a grid with a guard `^`, spaces avaiable to move to `.`, and blockaids `#`
# Progress the guard through the grid
# As the guard moves in the direction it is facing,
# It will either hit:
# - Out of bounds: if the guard steps on a place that is outside the bounds of the grid, they "left"
# - A blockage: if the guard hits a blockage, the guard will turn clockwise 90 degrees and continue walking
# We need to keep track of how many "steps" the guard takes before "leaving"

# ....#.....
# .........#
# ..........
# ..#.......
# .......#..
# ..........
# .#..^.....
# ........#.
# #.........
# ......#...
