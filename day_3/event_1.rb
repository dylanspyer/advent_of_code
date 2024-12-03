require 'yaml'

sample_data1 = YAML.load_file('data.yml')['sample_data1']
sample_data2 = YAML.load_file('data.yml')['sample_data2']

# xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))

def part1(string)
  pattern = /mul\(\d+,\d+\)/
  muls = string.scan(pattern)
  muls.map { |mul| mul.scan(/\d+/).map(&:to_i).reduce(:*) }.sum
end

p part1(sample_data1)
p part1(sample_data2)
