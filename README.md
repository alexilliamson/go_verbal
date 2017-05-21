# go_verbal


Ruby access to the congressional record text 
https://www.gpo.gov/fdsys/browse/collection.action?collectionCode=CREC

## download URL collection to local YAML files

Download 2017

```ruby
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
```


## download URL collection to local YAML files
Load 

## Database Setup

### Run migrations
sequel -m db/migrations sqlite://dev.db

### Reset
sequel -m db/migrations -M 0 sqlite://dev.db

## Transfer YAML to DB

```ruby
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

```



## Populate DB with content






```ruby
DB = Sequel.sqlite('dev.db')
browser = GoVerbal::GPOSiteBrowser.new

counter = 0

DB[:pages].where("content is null").each do |page|
  if (counter % 1000) == 0
    puts(Time.now)
    puts(page[:date])
  end

  id = page[:id]
  url = page[:url]

  page = browser.go_to(url)
  content = page.body

  DB[:pages].where(:id => id).update(content: content)
  counter += 1
end
```
