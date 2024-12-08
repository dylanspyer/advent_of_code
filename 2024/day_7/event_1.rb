require 'yaml'

sample_data1 = YAML.load_file('data.yml')['sample_data1']
sample_data2 = YAML.load_file('data.yml')['sample_data2']

def build_equations_hash(data)
  hash = {}

  data.split(/\n/).each do |l|
    k, v_arr = l.split(': ')
    hash[k] = v_arr.split(' ').map(&:to_i)
  end

  hash
end

def includes_test_val?(nums, test_val)
  if nums.length == 1
    return true if nums[0] == test_val

    return false
  end

  rest = nums[2..] || []
  true if includes_test_val?([nums[0] + nums[1]] + rest, test_val) ||
          includes_test_val?([nums[0] * nums[1]] + rest, test_val) ||
          includes_test_val?([(nums[0].to_s + nums[1].to_s).to_i] + rest, test_val)
end

def part1(data)
  equations = build_equations_hash(data)

  equations.reduce(0) do |memo, (test_val, nums)|
    test_val = test_val.to_i

    includes_test_val?(nums, test_val) ? memo + test_val : memo
  end
end

def part2(data)
  equations = build_equations_hash(data)
end

p part1(sample_data1)
p part1(sample_data2)

# {
#   190: [10 19]
#   3267: [81 40 27]
#   83: [17 5]
#   156: [15 6]
#   7290: [6 8 6 15]
#   161011: [16 10 13]
#   192: [17 8 14]
#   21037: [9 7 18 13]
#   292: [11 6 16 20]
# }

# Brute Force Approach
# Loop through the values associated with each key
# Try every permutation of multiply and dividing the numbers
# 81 + 40 + 27
# 81 * 40 * 27
# 81 * 40 + 27
# 81 + 40 * 27
# Optimized
# Use recurision and a cache
# [81, 40, 27]
# Base case: when the array is empty
# When the length of the array is 1, return the number
# [81, 40, 27]
# 121 [27]

# [148, 3267, 3267, 87480]
