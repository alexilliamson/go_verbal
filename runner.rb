require_relative 'lib/go_verbal'

DB = Sequel.connect(ENV.fetch("DATABASE_URL"))
n_texts = 0

index = GoVerbal.build_index

puts(Time.now)
download = GoVerbal::download_congressional_record(directory: "text_files/2016", options: { year: "2016" })


download.start

puts(Time.now)
