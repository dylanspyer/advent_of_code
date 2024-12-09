require 'yaml'

sample_data1 = YAML.load_file('data.yml')['sample_data1']
sample_data2 = YAML.load_file('data.yml')['sample_data2']
# sample_data2 = File.read('input.txt')

# 00...111...2...333.44.5555.6666.777.888899
# 009..111...2...333.44.5555.6666.777.88889.
# 0099.111...2...333.44.5555.6666.777.8888..
# 00998111...2...333.44.5555.6666.777.888...
# 009981118..2...333.44.5555.6666.777.88....
# 0099811188.2...333.44.5555.6666.777.8.....
# 009981118882...333.44.5555.6666.777.......
# 0099811188827..333.44.5555.6666.77........
# 00998111888277.333.44.5555.6666.7.........
# 009981118882777333.44.5555.6666...........
# 009981118882777333644.5555.666............
# 00998111888277733364465555.66.............
# 0099811188827773336446555566..............

# For a given line
# Keep a pointer where the next number will go and progress it when we place the next number
# - Starts are the leftmost side of the array
# - Moves until it finds a `.`
# - Then moves only when we move a number to it
# Use another pointer to find the numbers to move
# - Starts at the rightmost side of the array
# - Moves left whenever the element it points to is not a number
# - If the element is a number, move that number to the left pointer and set right pointer equal to `.`
# The process is complete when the two pointers cross each other

def part1(line)
  line = line.strip

  block = []
  id = '0'
  line.each_char.with_index do |c, i|
    if i.even?
      block.concat([id] * c.to_i)
      id = id.to_i + 1
      id = id.to_s
    else
      block.concat(['.'] * c.to_i)
    end
  end

  l = 0
  r = block.length - 1

  while l < r
    r -= 1 while block[r] == '.'
    l += 1 while block[l] != '.'

    block[l], block[r] = block[r], block[l]
  end

  block.each_with_index.reduce(0) { |checksum, (c, i)| checksum + c.to_i * i }
end

p part1 sample_data2
p part1 sample_data1

# 0099811188827773336446555566..............
# 0099811188827773336446555566..............
