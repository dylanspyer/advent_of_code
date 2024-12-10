require 'yaml'

sample_data1 = YAML.load_file('data.yml')['sample_data1'].strip
sample_data2 = YAML.load_file('data.yml')['sample_data2'].strip

def get_files(disk_map)
  disk_map.split('').flat_map.with_index { |size, i| { id: i.odd? ? '.' : i / 2, size: size.to_i } }
end

# FINISH THIS METHOD TOMORROW
def compact_files(files)
  (0...files.length).reverse_each do |j|
    file = files[j]
    next if file[:id] == '.'

    (0...j).each do |i|
      free = files[i]
      next unless free[:id] == '.' && free[:size] >= file[:size]

      free[:size] -= file[:size]
      files[j] = { id: '.', size: file[:size] }
      files.insert(i, file)
      break
    end
  end
end

def calculate_checksum(formatted_dm)
  formatted_dm.each_with_index.reduce(0) { |checksum, (c, i)| checksum + c.to_i * i }
end

def part2(disk_map)
  files = get_files(disk_map)
  compact_files(files)
  compacted_formatted = files.flat_map { |file| Array.new(file[:size], file[:id]) }

  calculate_checksum(compacted_formatted)
end

p part2 sample_data1
# p part2 sample_data2

# [{:id=>0, :size=>2}, {:id=>".", :size=>3}, {:id=>1, :size=>3}, {:id=>".", :size=>3}, {:id=>2, :size=>1},
# {:id=>".", :size=>3}, {:id=>3, :size=>3}, {:id=>".", :size=>1}, {:id=>4, :size=>2}, {:id=>".", :size=>1},
# {:id=>5, :size=>4}, {:id=>".", :size=>1}, {:id=>6, :size=>4}, {:id=>".", :size=>1}, {:id=>7, :size=>3}, {:id=>".", :size=>1}, {:id=>8, :size=>4}, {:id=>".", :size=>0}, {:id=>9, :size=>2}]
