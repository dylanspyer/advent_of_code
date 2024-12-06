require 'yaml'

updates2 = YAML.load_file('data.yml')['updates2']

def parse_updates(updates)
  updates.split(/\n/).map { |s| s.split(',').map(&:to_i) }
end
