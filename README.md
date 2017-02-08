#GoVerbal
The Congressional Record:  Access and (coming soon) Analysis

##Access
> Enumerate all pages of congressional record text

```ruby
require 'go_verbal'

record = GoVerbal.congressional_record

record.download(directory: "text_files", year: 2016) do |dl|
  sleep(1)
  if ((counter  += 1) % 100 == 10)
    puts(dl)
    puts(Time.now)
  end
end
```


To run migrations, sequel -m db/migrations sqlite://test.db
To reset, sequel -m db/migrations -M 0 sqlite://test.db

