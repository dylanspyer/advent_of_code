require 'yaml'
require_relative 'parse_input'

sample_data1 = YAML.load_file('data.yml')['sample_data1']
sample_data2 = YAML.load_file('data.yml')['sample_data2']

def left_right_up_diag_mas?(grid, row, col)
  match = 'MAS'
  match_pointer = 0

  3.times do |i|
    r = row - i
    c = col + i

    break unless r >= 0 && grid[row] && c < grid[row].length

    if grid[r][c] == match[match_pointer]
      match_pointer += 1

      next
    end

    break
  end

  match_pointer == 3
end

def left_right_down_diag_mas?(grid, row, col)
  match = 'MAS'
  match_pointer = 0
  3.times do |i|
    r = row + i
    c = col + i

    break unless r < grid.length && grid[r] && c < grid[r].length

    if grid[r][c] == match[match_pointer]
      match_pointer += 1
      next
    end

    break
  end

  match_pointer == 3
end

def right_left_up_diag_mas?(grid, row, col)
  match = 'MAS'
  match_pointer = 0

  3.times do |i|
    r = row - i
    c = col - i

    break unless c >= 0 && r >= 0

    if grid[r][c] == match[match_pointer]
      match_pointer += 1
      next
    end

    break
  end

  match_pointer == 3
end

def right_left_down_diag_mas?(grid, row, col)
  match = 'MAS'
  match_pointer = 0
  3.times do |i|
    r = row + i
    c = col - i

    break unless r < grid.length && c >= 0

    if grid[r][c] == match[match_pointer]
      match_pointer += 1
      next
    end

    break
  end

  match_pointer == 3
end

def part2(data)
  grid = parse_input(data)
  matched = 0

  grid.each_with_index do |string, row_idx|
    string.each_char.with_index do |char, col_idx|
      next unless char == 'A'

      # rubocop:disable Layout/LineLength
      matched += 1 if left_right_down_diag_mas?(grid, row_idx - 1, col_idx - 1) && left_right_up_diag_mas?(grid, row_idx + 1, col_idx - 1)
      matched += 1 if right_left_down_diag_mas?(grid, row_idx - 1, col_idx + 1) && right_left_up_diag_mas?(grid, row_idx + 1, col_idx + 1)
      matched += 1 if left_right_up_diag_mas?(grid, row_idx + 1, col_idx - 1) && right_left_up_diag_mas?(grid, row_idx + 1, col_idx + 1)
      matched += 1 if left_right_down_diag_mas?(grid, row_idx - 1, col_idx - 1) && right_left_down_diag_mas?(grid, row_idx - 1, col_idx + 1)
      # rubocop:enable Layout/LineLength
    end
  end

  matched
end

p part2 sample_data2
p part2 sample_data1

# left to right down && left to right up
# right to left down && right to left up
# left to right up && right to left up
# left to right down && right to left down
