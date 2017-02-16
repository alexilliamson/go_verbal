require_relative 'lib/go_verbal'

index = GoVerbal.build_index

puts(Time.now)
record = GoVerbal.congressional_record
counter = 0

(2017..2017).each do |y|
  new_dir = "text_files/#{y}"
  Dir.mkdir new_dir
  record.download(directory: new_dir, year: y) do |dl|
    # sleep(1)
    if ((counter  += 1) % 1000 == 10)
      puts(dl)
      puts(Time.now)
    end
  end

  puts(Time.now)
end
