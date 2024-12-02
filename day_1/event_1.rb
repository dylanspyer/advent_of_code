require_relative 'parse_input'
require_relative 'input_data'

def total_distance(list1, list2)
  list = []
  sorted_list1 = list1.sort
  sorted_list2 = list2.sort

  sorted_list1.each_with_index do |val1, idx|
    val2 = sorted_list2[idx]
    delta = (val1 - val2).abs
    list << delta
  end

  list.sum
end

list1, list2 = parse_input(InputData::SAMPLE_DATA)

p total_distance(list1, list2)
