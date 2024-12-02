require_relative 'parse_input'
require 'yaml'

sample_data = YAML.load_file('input_data.yml')['sample_data']

def get_counts(list)
  list.each_with_object({}) { |val, hash| hash[val] = hash.fetch(val, 0) + 1 }
end

def similarity_score(list1, list2)
  counts = get_counts(list2)

  score = 0
  list1.each do |val|
    appearances = counts.fetch(val, 0)

    score += (val * appearances)
  end

  score
end

list1, list2 = parse_input(sample_data)
p similarity_score(list1, list2)
