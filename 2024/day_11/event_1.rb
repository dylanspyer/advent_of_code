require 'yaml'

sample_data1 = YAML.load_file('data.yml')['sample_data1']
sample_data2 = YAML.load_file('data.yml')['sample_data2']
sample_data3 = YAML.load_file('data.yml')['sample_data3']

# Problem Statement
# Iterate through the list of stones 25 times
# For each stone, apply the rules
# - If 0, change to 1
# - If even number of digits, split down the middle and drop leading 0's
# - If neither of the above, multiply by 2024
# Example
# ["0", "1", "10", "99", "999"]
# [1, 2024, 1, 0, 9, 9, 202197]
# [2024, 20, 24, 2024, 1, 18216, 18216, 202, 197]
# idx 0 => 2024; idx 1 => 20
# [20, 24, ...]
# idx 1 => 24 (the index no longer points at the correct number)
# ...
# [125, 17]
# [253000, 1, 7]
# [253, 000, 2024, 14168]
# Data Structure / Algorithm
# At a high level, loop through the list of numbers 25 times performing the required transformations on each loop
# Potential downfall: iterating over a dynamic list and adding new elements
# - Use flat map
# Idea:
# - Collect all the transformations without applying them, then apply them all after ea iteration
# - Update the iteration index dynamically applying all of the transformations
# => array.length == 7
# => array.length == 10
# Dry Run
# [1, 2024, 1, 0, 9, 9, 202197]
# [mult, split, mult, flip, mult, mult, split]
# [2024, [20,24], 2024, 1, 18216, 18216, [202, 197]], then flatten the array
# [2024, 20, 24, 2024, 1, 18216, 18216, 202, 197], then update the top of the range we are iterating over

def flip
  1
end

def mult(num)
  num * 2024
end

def split(num)
  s = num.to_s
  m = s.length / 2

  [s[0...m], s[m...s.length]].map(&:to_i)
end

def part1(data)
  stones = data.split.map(&:to_i)
  length = stones.length
  times = 75
  memo = {}
  while times.positive?
    stones = stones.flat_map.with_index do |stone, i|
      next memo[stone] if memo.key?(stone)

      result = if stone.zero?
                 1
               elsif stone.to_s.length.even?
                 s = stone.to_s
                 m = s.length / 2
                 [s[0...m], s[m..-1]].map(&:to_i)
               else
                 stone * 2024
               end

      memo[stone] = result
    end

    times -= 1
  end
  stones.length
end

p part1(sample_data3)
