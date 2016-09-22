#GoVerbal
The Congressional Record:  Access and Analysis

##Access
Accessing the Congressional Record programmatically used to be hard.  Now it's a little easier.

URLs containing pages of congressional record text are enumerated to you.
```ruby
require 'go_verbal'
index = GoVerbal.build_index

text_page_enumerator = index.text_pages

sample_text_page = text_page_enumerator.next
```

##Analysis
Coming soon
