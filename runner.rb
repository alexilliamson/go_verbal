require_relative 'lib/go_verbal'

index = GoVerbal.build_index

puts(Time.now)
record = GoVerbal.congressional_record
counter = 0
record.download(directory: "text_files", year: 2015) do |dl|
  # sleep(1)
  if ((counter  += 1) % 100 == 10)
    puts(dl)
    puts(Time.now)
  end
end

puts(Time.now)
