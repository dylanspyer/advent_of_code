require 'yaml'

sample_data2 = YAML.load_file('data.yml')['sample_data2']
sample_data3 = YAML.load_file('data.yml')['sample_data3']

# xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))

def part2(string)
  current_instruction = 'do()'
  instructions_pattern = /do\(\)|don't\(\)/
  pattern = /mul\(\d+,\d+\)|do\(\)|don't\(\)/

  string.scan(pattern).reduce(0) do |result, mul|
    if mul.match(instructions_pattern)
      current_instruction = mul
      result
    elsif current_instruction == 'do()'
      result + mul.scan(/\d+/).map(&:to_i).reduce(:*)
    else
      result
    end
  end
end

p part2(sample_data3)
p part2(sample_data2)
