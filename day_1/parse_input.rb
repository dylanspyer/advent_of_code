def parse_input(input)
  list_1 = []
  list_2 = []

  input = input.split(' ').map(&:to_i)
  input.each.with_index do |val, i|
    if i.even?
      list_1 << val
    else
      list_2 << val
    end
  end

  [list_1, list_2]
end
