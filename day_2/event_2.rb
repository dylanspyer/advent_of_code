require_relative 'parse_input'
require 'yaml'

sample_data1 = parse_input(YAML.load_file('input_data.yml')['sample_data1'])
sample_data2 = parse_input(YAML.load_file('input_data.yml')['sample_data2'])
sample_data3 = parse_input(YAML.load_file('input_data.yml')['sample_data3'])

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

  report.each_with_index do |num, idx|
    next unless idx.positive?

    prev_num = report[idx - 1]

    next if adjacent_level_tolerance?(prev_num, num) && uniform_direction?(prev_num, num, report_direction)

    return false
  end

  true
end

def safe_count(data)
  count = 0

  data.each do |report|
    if report_safe?(report)
      count += 1 if report_safe?(report)
    else
      report.length.times do |idx|
        new_report = report[0...idx] + report[idx + 1...report.length]
        if report_safe?(new_report)
          count += 1
          break
        end
      end
    end
  end

  count
end

# p safe_count sample_data1
p safe_count sample_data2
# p safe_count sample_data3
