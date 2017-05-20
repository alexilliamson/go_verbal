require_relative 'lib/go_verbal'

DB = Sequel.sqlite('dev.db')

def each_yaml_file
  (2017..2017).each do |y|
    dir = "text_files/#{y}"
    Dir.glob("#{dir}/*.yml") do |file|
      yield Psych.load_file(file)
    end
  end
end

enum = to_enum(:each_yaml_file)

next_enum = enum.next

counter = 0

while next_enum do
  if (counter % 10000) == 0
    puts(next_enum)
    puts(Time.now)
  end
  begin
    DB[:pages].insert(next_enum)
  rescue Sequel::UniqueConstraintViolation
    puts(next_enum.to_s + "already inserted")
  end
  next_enum = enum.next
  counter += 1
end
