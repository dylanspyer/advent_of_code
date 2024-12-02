def parse_input(input)
  input.split("\n").map { |string| string.split(' ').map(&:to_i) }
end
