require 'yaml'

updates1 = YAML.load_file('data.yml')['updates1']
rules1 = YAML.load_file('data.yml')['rules1']
updates2 = YAML.load_file('data.yml')['updates2']
rules2 = YAML.load_file('data.yml')['rules2']
# [[75, 47, 61, 53, 29], [97, 61, 53, 29, 13], [75, 29, 13], [75, 97, 47, 61, 53], [61, 13, 29], [97, 13, 75, 29, 47]]
# sample_data2 = YAML.load_file('data.yml')['sample_data2']

# Problem Statement
# Given a set of rules in <number-a>|<number-a> format, and a list of numbers (array of subarrays)
# Where the rules dictate the relative positions of each number
# Check each subarray to see if the numbers within it follow the rules
# For example, if there is a rule 47|53, that means 47 must come before 53
# If a particular subarray follows all the rules,
# Get its middle number and add it to a running sum
# Return the sum after you've checked all the subarrays

# Examples
# rules => 75|53, 75|47, 75|13, 75|61, 75|29, 47|53, 47|29, 47|13, 47|61, 61|13, 61|53, 61|29, 53|29, 53|13, 29|13
# sub   => [75, 47, 61, 53, 29]
# Note
# - Not all rules will pertain to all subarrays (the rules broadly apply to the entire set of subarrays)

# Data Structure
# rules
# {
#   75: [53, 47, 13, 61, 29],
#   <number>: <array of nums that it comes before>
# }
# seen
# {
#   75: true,
#   47: true,
#   <number>: <boolean indicating if it's been seen>
# }

# Approach
# Build a hash of the rules: <number>: <array of numbers that come before it>
# Iterate through the subarrays
# Keep track of the numbers you've seen so far in a seen hash map
# For a given number, look it up in the rules hash map
# Rules hash map will say which numbers it should come before
# - Iterate through the array of rules associated with the number in the rules hash
# - If any particular number is already in the `seen` hash, the subarray is invalid
# If you get to the end of the subarray without invalidating it,
# - Get the middle number of the subarray and add it to a running sum
# - Return the running sum

# Dry run
# seen =
# {
#   75: true,
#   47: true
# }
# [75, 47, 61, 53, 29]
#
#

def build_rules_hash(rules)
  rule_hash = {}

  rules.split(/\n/).map do |rule|
    num, rule_num = rule.split('|').map(&:to_i)

    rule_hash[num] = rule_hash.fetch(num, []) << rule_num
  end

  rule_hash
end

def parse_updates(updates)
  updates.split(/\n/).map { |s| s.split(',').map(&:to_i) }
end

def update_valid?(update, rules)
  seen = {}

  update.each do |num|
    seen[num] = true
    next unless rules[num]

    rules[num].each do |rule|
      return false if seen[rule]
    end
  end

  true
end

def part1(updates_string, rules_string)
  updates = parse_updates(updates_string)
  rules = build_rules_hash(rules_string)

  updates.reduce(0) do |result, update|
    update_valid?(update, rules) ? result + update[update.length / 2] : result
  end
end

# p part1(updates1, rules1)
# p part1(updates2, rules2)
