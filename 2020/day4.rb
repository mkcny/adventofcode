# typed: false
passports = File.read("input/day4")
  .split("\n\n")
  .map { Hash[_1.scan(/([a-z]+):([\w#]+)/)] }


# Part 1

REQUIRED_FIELDS = [ 'byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid' ]
puts passports.count { |fields| REQUIRED_FIELDS.all? { fields.key?(_1) } } if __FILE__ == $0


# Part 2

REQUIRED_FIELDS_WITH_VALIDATORS = {
  'byr' => ->(x) { (1920..2002).cover?(x.to_i) },
  'iyr' => ->(x) { (2010..2020).cover?(x.to_i) },
  'eyr' => ->(x) { (2020..2030).cover?(x.to_i) },
  'hgt' => ->(x) {
      height, unit = x.match(/^([0-9]+)(cm|in)$/)&.captures
      return (unit == "cm" && (150..193).cover?(height.to_i)) ||
        (unit == "in" && (59..76).cover?(height.to_i))
    },
  'hcl' => ->(x) { x.match?(/^#[a-f0-9]{6}$/) },
  'ecl' => ->(x) { %w(amb blu brn gry grn hzl oth).include?(x) },
  'pid' => ->(x) { x.match?(/^\d{9}$/) }
}

puts passports.count { |fields|
  REQUIRED_FIELDS_WITH_VALIDATORS.all? do |field_name, validator|
    fields.key?(field_name) && validator.(fields[field_name])
  end
} if __FILE__ == $0
