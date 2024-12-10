require 'yaml'

sample_data1 = YAML.load_file('data.yml')['sample_data1']
sample_data2 = YAML.load_file('data.yml')['sample_data2']
sample_data3 = YAML.load_file('data.yml')['sample_data3']

def dfs(row, col, grid, count)
  return count[:count] += 1 if grid[row][col] == '9'

  adjacent = [[-1, 0], [1, 0], [0, -1], [0, 1]]

  adjacent.each do |pos|
    next_row = row + pos[0]
    next_col = col + pos[1]

    valid = next_row >= 0 && next_row < grid.length &&
            next_col >= 0 && next_col < grid[next_row].length &&
            grid[next_row][next_col] == (grid[row][col].to_i + 1).to_s

    next unless valid

    dfs(row + pos[0], col + pos[1], grid, count)
  end
end

def part1(data)
  grid = data.split
  count = { count: 0 }
  trailheads = []

  grid.each_with_index do |row, i|
    row.each_char.with_index do |_, j|
      trailheads << [i, j] if grid[i][j] == '0'
    end
  end

  trailheads.each do |trailhead|
    row, col = trailhead

    dfs(row, col, grid, count)
  end
  count
end

p part1(sample_data3)

# "89010123"
# "78121874"
# "87430965"
# "96549874"
# "45678903"
# "32019012"
# "01329801"
# "10456732"

# Problem Statement:
#
# Given a grid of numbers
# Where `0`'s represent trail heads and `9`'s represent the end of the trail
# Figure out the trailhead scores (number of 9-height positions reachable from that trailhead)
# - The path must be gradually increasing (each step increases by exactly 1)
# - No diagonal steps, only up, down, left, right
# Get all the trailhead scores (each `0`'s number of times it can reach a `9`) and return the sum
#
# Examples:
# ...0...
# ...1...
# ...2...
# 6543456
# 7.....7
# 8.....8
# 9.....9
#
# Algo:
# Find the positions of all the trailheads
# Iterate through those positions
# Recursively find how many `9`'s the particular trailhead can reach
# - For each trailhead, run dfs on it
# - If you reach a '9', increment a count variable
# - Keep track of the '9's you've already visited and don't double count
# - Reset the visited state on each trailhead
