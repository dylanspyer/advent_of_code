# Didn't complete this one...
# Ran out of time :(
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

def move(row, col, grid)
  directions = [[-1, 0], [0, 1], [1, 0], [0, -1]]
  curr_dir_idx = 0
  cycles = 0
  start_row = row
  start_col = col

  # For each direction the guard can go, place a block then run this loop:
  directions.each do |direction|
    block_row = start_row + direction[0]
    block_col = start_col + direction[1]

    next if grid[block_row][block_col] == '#'

    grid[block_row][block_col] = '#'

    visited = { 'up' => [], 'down' => [], 'left' => [], 'right' => [] }

    while row_valid?(row, grid) && col_valid?(row, col, grid)
      next_row = row + directions[curr_dir_idx][0]
      next_col = col + directions[curr_dir_idx][1]

      curr_dir_idx = (curr_dir_idx + 1) % directions.length if grid[next_row] && grid[next_row][next_col] == '#'

      case curr_dir_idx % directions.length
      when 0
        dir = 'up'
      when 1
        dir = 'right'
      when 2
        dir = 'down'
      when 3
        dir = 'left'
      end

      row += directions[curr_dir_idx][0]
      col += directions[curr_dir_idx][1]
      if visited[dir].include?([row, col])
        cycles += 1
        break
      else
        visited[dir] << [row, col]
      end
    end

    grid[block_row][block_col] = '.'
    row = start_row
    col = start_col
    curr_dir_idx = 0
  end
  cycles
end

def part2(data)
  grid = parse_data(data)
  directions = [[-1, 0], [0, 1], [1, 0], [0, -1]]

  row, col = find_start(grid)
  curr_dir_idx = 0
  cycles = 0

  while row_valid?(row, grid) && col_valid?(row, col, grid)
    next_row = row + directions[curr_dir_idx][0]
    next_col = col + directions[curr_dir_idx][1]

    cycles += move(next_row, next_col, grid)

    curr_dir_idx = (curr_dir_idx + 1) % directions.length if grid[next_row] && grid[next_row][next_col] == '#'

    # if row_valid?(row, grid) && col_valid?(row, col, grid) && grid[row][col] != 'X'
    #   grid[row][col] = 'X'
    # end

    row += directions[curr_dir_idx][0]
    col += directions[curr_dir_idx][1]
  end

  # Traverse the guard through the grid
  # Call move each time
  # Move will return the cycles for that particular cell
  cycles
end

# p part2(sample_data1)
p part2(sample_data2)

# Part 1
# Given a grid with a guard `^`, spaces avaiable to move to `.`, and blockaids `#`
# Progress the guard through the grid
# As the guard moves in the direction it is facing,
# It will either hit:
# - Out of bounds: if the guard steps on a place that is outside the bounds of the grid, they "left"
# - A blockage: if the guard hits a blockage, the guard will turn clockwise 90 degrees and continue walking
#
# Part 2
# Identify places to add an obstacle that create a cycle
# The guard still moves in the same directions as before, and all of the previous rules apply
# Exploring...
# What are the properties of a cycle?
# - To identify a cycle, you can keep track of what cells the guard visited and the direction he was going
# -- If the guard visits the same cell twice in the same direction, it's a cycle
# Brute force
# Iterate through the grid and keep track of the cells the guard visits and the direction they were going
# For each cell
# - Place an obstruction in the 4 possible directions
# - Check for a cycle and keep track if there is one (guard visited same cell going same direction)

# "....#.....",
# ".........#",
# "..........",
# "..#.......",
# ".......#..",
# "..........",
# ".#.#^.....",
# "........#.",
# "#.........",
# "......#..."
