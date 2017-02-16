require_relative 'lib/go_verbal'
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
