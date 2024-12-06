def parse_input(input)
  list1 = []
  list2 = []

  input = input.split(' ').map(&:to_i)
  input.each.with_index do |val, i|
    if i.even?
      list1 << val
    else
      list2 << val
    end
  end

  [list1, list2]
end
