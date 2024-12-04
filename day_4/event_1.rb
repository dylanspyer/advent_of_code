require 'yaml'
require_relative 'parse_input'

sample_data1 = YAML.load_file('data.yml')['sample_data1']
sample_data2 = YAML.load_file('data.yml')['sample_data2']

# PROBLEM DEFINITION
# Given a string input
# Iterate through it and count the number of times the word "XMAS" appears
# It can appear forward, backward, diagonal

# Iterate through the string
# For each position,
# - Check right
# - Check left
# - Check forward diagonal
# - Check backward diagonal
# Get the letter
# Check it against the letter it is supposed to be
# Move on to the next position in the current direction if letter is correct
# Stop checking the current direction if the letter is incorrect

def forward_xmas?(grid, row, col)
  match = 'XMAS'
  match_pointer = 0

  col.upto(col + 3) do |c_idx|
    break unless c_idx < grid[row].length

    c = grid[row][c_idx]
    m = match[match_pointer]

    if c == m
      match_pointer += 1
      next
    end

    break
  end

  match_pointer == 4
end

def backward_xmas?(grid, row, col)
  match = 'XMAS'
  match_pointer = 0
  col.downto(col - 3) do |c_idx|
    break unless col >= 0

    c = grid[row][c_idx]
    m = match[match_pointer]

    if c == m
      match_pointer += 1
      next
    end

    break
  end

  match_pointer == 4
end

def upward_xmas?(grid, row, col)
  match = 'XMAS'
  match_pointer = 0
  row.downto(row - 3) do |r_idx|
    break unless r_idx >= 0

    c = grid[r_idx][col]
    m = match[match_pointer]

    if c == m
      match_pointer += 1
      next
    end

    break
  end

  match_pointer == 4
end

def downward_xmas?(grid, row, col)
  match = 'XMAS'
  match_pointer = 0
  row.upto(row + 3) do |r_idx|
    break unless r_idx < grid.length

    c = grid[r_idx][col]
    m = match[match_pointer]

    if c == m
      match_pointer += 1
      next
    end

    break
  end

  match_pointer == 4
end

def left_right_up_diag_xmas?(grid, row, col)
  match = 'XMAS'
  match_pointer = 0

  4.times do |i|
    r = row - i
    c = col + i

    break unless r >= 0 && c < grid[row].length

    if grid[r][c] == match[match_pointer]
      match_pointer += 1

      next
    end

    break
  end

  match_pointer == 4
end

def left_right_down_diag_xmas?(grid, row, col)
  match = 'XMAS'
  match_pointer = 0
  4.times do |i|
    r = row + i
    c = col + i

    break unless r < grid.length && c < grid[r].length

    if grid[r][c] == match[match_pointer]
      match_pointer += 1
      next
    end

    break
  end

  match_pointer == 4
end

def right_left_up_diag_xmas?(grid, row, col)
  match = 'XMAS'
  match_pointer = 0

  4.times do |i|
    r = row - i
    c = col - i

    break unless c >= 0 && r >= 0

    if grid[r][c] == match[match_pointer]
      match_pointer += 1
      next
    end

    break
  end

  match_pointer == 4
end

def right_left_down_diag_xmas?(grid, row, col)
  match = 'XMAS'
  match_pointer = 0
  4.times do |i|
    r = row + i
    c = col - i

    break unless r < grid.length && c >= 0

    if grid[r][c] == match[match_pointer]
      match_pointer += 1
      next
    end

    break
  end

  match_pointer == 4
end

def part1(data)
  grid = parse_input(data)
  matched = 0

  grid.each_with_index do |string, row_idx|
    string.each_char.with_index do |char, col_idx|
      next unless char == 'X'

      matched += 1 if forward_xmas?(grid, row_idx, col_idx)
      matched += 1 if backward_xmas?(grid, row_idx, col_idx)
      matched += 1 if upward_xmas?(grid, row_idx, col_idx)
      matched += 1 if downward_xmas?(grid, row_idx, col_idx)
      matched += 1 if left_right_up_diag_xmas?(grid, row_idx, col_idx)
      matched += 1 if left_right_down_diag_xmas?(grid, row_idx, col_idx)
      matched += 1 if right_left_up_diag_xmas?(grid, row_idx, col_idx)
      matched += 1 if right_left_down_diag_xmas?(grid, row_idx, col_idx)
    end
  end

  matched
end

p part1 sample_data2
p part1 sample_data1
