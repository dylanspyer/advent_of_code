require 'yaml'

sample_data1 = YAML.load_file('data.yml')['sample_data1']
sample_data2 = YAML.load_file('data.yml')['sample_data2']
sample_data3 = YAML.load_file('data.yml')['sample_data3']
puzzle_input = YAML.load_file('data.yml')['puzzle_input']

# Terms
# - Region    -> Contiguous set of a single character
# - Perimeter -> Sides of a region that don't touch a character of that region
# Problem Statement
# Given a grid of letters representing garden plots
# - Find the area of each region (the number of contiguous characters)
# - Find the perimeter each region (sides of the region that don't touch another region)
# - Find the cost of each region (the area of a particular region * the perimeter of that same region)
# Note that you can have multiple regions of the same character (2 regions of X that don't touch each other for example)
# Examples
# OOOOO
# OXOXO
# OOOOO
# OXOXO
# OOOOO
# 1 region of `O`
# - Perimeter is 36 (total area outside plus the sides touching each `X`)
# - Area is 21 (simply count all of the O's since they all touch)
# 4 regions of `X`. Each region:
# - Perimeter is 4 (all 4 sides of the single `X` touch an `O`)
# - Area is 1 (there is 1 `X` per region)
# Data Structures & Algorithm
# - Iterate through the grid
# - For each cell, BFS to find the region associated with that cell, keeping track of visited cells
# - Through this process, keep track of the area and perimeter of the particular region
# - => For each cell in the region, increment area
# - => For each cell in the region that touches an out of bounds cell, increment perimeter
# - => For each cell in the region that touches a cell of another region, increment perimeter
# - If you've been to a cell already, skip it
# - After all the regions are mapped, figure out the cost by doing math
# Pseudocode
# Init a queue
# Init a visited set { [0, 0], [0, 1], ...}
# Init a regions data structure (array of sub arrays with perimeter and area)
# Loop through the grid by cell
# If we already have a region associated with the particular cell, skip it (how do we know?)
# - As we map a region out, set the chars of that region to `.`
# - Then we can simply skip the `.`'s
# Otherwise, put it in the queue
# Init a variable to track area
# Init a variable to track perimeter
# While there are elements in the queue
# Pop one from the front of the queue
# Check it's neighbors
# - Row above
# - Row below
# - Col left
# - Col right
# If we visited the neighbor, skip it
# If the neighbor is the same as curr cell, put it in the queue
# If the neighbor is a different type or out of bounds, increment perimeter
# Increment area
# Mark the cell as visited
# After you mapped all the regions, use regions DS to calculate the price (multiply sub arrays, sum outer array)

# Finding Corners
# Corner => cell in a particular region that has neighbors of different characters or at grid boundary
# Corner definition
# - A corner is a boundary cell
# To identify an outside corner:
# - An outside corner has a left or right neighbor that is dissimilar to it
# - An outside corner has

CORNER_POS = {
  u_l_ul: [[-1, 0], [0, -1], [-1, -1]],
  u_r_ur: [[-1, 0], [0, 1], [-1, 1]],
  d_l_dl: [[1, 0], [0, -1], [1, -1]],
  d_r_dr: [[1, 0], [0, 1], [1, 1]]
}.freeze

DIRECTIONS = [[1, 0], [-1, 0], [0, 1], [0, -1]].freeze

def corner_count(char, row, col, grid)
  count = 0

  CORNER_POS.each_value do |pos_arr|
    neighbors = pos_arr.map do |pos|
      grid[row + pos[0]][col + pos[1]] unless out_of_bounds?(row + pos[0], col + pos[1], grid)
    end

    count += 1 if corner?(char, neighbors)
  end

  count
end

def outer_corner?(char, neighbors)
  neighbors.all? { |c| c != char }
end

def inner_corner?(char, neighbors)
  neighbors[0..1].all? { |c| c == char } && neighbors[2] != char ||
    neighbors[0..1].all? { |c| c != char } && neighbors[2] == char
end

def corner?(char, neighbors)
  outer_corner?(char, neighbors) || inner_corner?(char, neighbors)
end

def out_of_bounds?(row, col, grid)
  row.negative? || col.negative? || row >= grid.length || col >= grid[0].length
end

def explore_region(row, col, grid, visited)
  char = grid[row][col]
  q = Queue.new
  area = 0
  perimeter = 0

  q.enq([row, col])
  visited.add([row, col])
  perimeter += corner_count(char, row, col, grid)
  area += 1

  while q.size.positive?
    curr_row, curr_col = q.deq

    neighbors = DIRECTIONS.map { |dir| [curr_row + dir[0], curr_col + dir[1]] }
    neighbors.each do |neighbor|
      neighbor_row = neighbor[0]
      neighbor_col = neighbor[1]

      if out_of_bounds?(neighbor_row, neighbor_col,
                        grid) || grid[neighbor_row][neighbor_col] != char || visited.include?(neighbor)
        next
      else
        perimeter += corner_count(grid[neighbor_row][neighbor_col], neighbor_row, neighbor_col,
                                  grid)
      end

      area += 1 if grid[neighbor_row][neighbor_col] == char
      q.enq(neighbor)
      visited.add(neighbor)
    end
  end

  [area, perimeter]
end

def part2(data)
  grid = data.split(/\n/)
  regions = []
  visited = Set.new

  grid.each_with_index do |row, row_index|
    row.each_char.with_index do |_, col_index|
      next if visited.include?([row_index, col_index])

      regions << explore_region(row_index, col_index, grid, visited)
    end
  end

  regions.map { |sub| sub.reduce(&:*) }.sum
end

p part2(sample_data1)

p part2(sample_data3)

p part2(puzzle_input)
