require_relative 'parse_input'
require 'yaml'

sample_data1 = parse_input(YAML.load_file('input_data.yml')['sample_data1'])
sample_data2 = parse_input(YAML.load_file('input_data.yml')['sample_data2'])

def get_direction(num1, num2)
  num2 - num1 >= 0 ? 'increasing' : 'decreasing'
end

def uniform_direction?(num1, num2, direction)
  curr_direction = get_direction(num1, num2)

  curr_direction == direction
end

def adjacent_level_tolerance?(num1, num2)
  abs_delta = (num1 - num2).abs
  [1, 2, 3].include?(abs_delta)
end

def report_safe?(report)
  report_direction = get_direction(report[0], report[1])
  bad_level_tolerant = true

  report.each_with_index do |num, idx|
    next unless idx.positive?

    prev_num = report[idx - 1]

    bad_adjacency = !adjacent_level_tolerance?(prev_num, num)
    bad_uniformity = !uniform_direction?(prev_num, num, report_direction)

    next unless bad_level

    return false
  end

  true
end

# options for dealing with bad level
# 1. break of out the loop and start a new loop with the sliced version omitting the bad level
# 2. recalulate the direction of the report and continue in the same loop

def safe_count(data)
  count = 0

  data.each { |report| count += 1 if report_safe?(report) }

  count
end

p safe_count sample_data1
p safe_count sample_data2
