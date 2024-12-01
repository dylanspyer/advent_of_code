require_relative 'parse_input'
require_relative 'input'

def similarity_score(list1, list2)
  counts = {}

  list2.each do |val|
    if counts[val]
      counts[val] += 1
    else
      counts[val] = 1
    end
  end

  score = 0
  list1.each do |val|
    appearances = counts.fetch(val, 0)

    score += (val * appearances)
  end

  score
end

list1, list2 = parse_input($input)
p similarity_score(list1, list2)
