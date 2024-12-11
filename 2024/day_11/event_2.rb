require 'yaml'

sample_data1 = YAML.load_file('data.yml')['sample_data1']
sample_data2 = YAML.load_file('data.yml')['sample_data2']
sample_data3 = YAML.load_file('data.yml')['sample_data3']

# 125
# 253000
# 253, 0 -> blink(0, 73, { a: b, c: d })
# 512072, 1
# 512, 72, 2024
# ...
# If I calculate 75 blinks starting at 0, I should never have to do that again
# Anytime I see a 0, I should return the answer I already calculated
# memo[[0, 75]] = x number of stones
# Approach
# Loop through the original list of numbers
# Find that numbers blink 75 score
# For all the other numbers that you recurse through, find their blink X score (75 - number we're currently on)
# Use a memo as you go to save calculations
#
# Given a stone and a number of blinks
# Execute a blink number of blinks times
# 2024
# 20 24
# 2 0 2 4
# 4048 1 4048 8096
# 40 48 2024 40 48 80 96
# 4 0 4 8 20 24 4 0 4 8 8 0 9 6
# ...
# Recursively call blink on the result for number of blink times until number of blink times is 0
# Return 1 when you pass a 0 for number of blink times (we can't blink anymore and the length is 0)

def part2(data)
  starting_stones = data.split.map(&:to_i)

  blink = lambda { |stone, num_of_blinks, memo|
    return memo[[stone, num_of_blinks]] if memo.key?([stone, num_of_blinks])
    return 1 if num_of_blinks.zero?

    new_stones = if stone.to_s.length.even?
                   s = stone.to_s
                   m = s.length / 2
                   [s[0...m], s[m..]].map(&:to_i)
                 elsif stone.zero?
                   1
                 else
                   stone * 2024
                 end

    result = if new_stones.is_a?(Array)
               new_stones.sum { |new_stone| blink.call(new_stone, num_of_blinks - 1, memo) }
             else
               blink.call(new_stones, num_of_blinks - 1, memo)
             end

    memo[[stone, num_of_blinks]] = result
  }

  starting_stones.sum { |stone| blink.call(stone, 75, {}) }
end

p part2(sample_data3)

# Problem
# Logic works, but it's not efficient enough to finish
# Potential Solution
# - Instead of working through the whole list at once, work through one number recursively 75 times
# - Memoize those results, so by the time you're on the next number, most of the work is done
