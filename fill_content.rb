require_relative 'lib/go_verbal'

pages_table = DB[:pages]

page_attributes = {
  url: 'https://www.gpo.gov/fdsys/pkg/CREC-1994-01-25/html/CREC-1994-01-25-pt1-PgD.htm',
  title: "140 Cong. Rec. D - Daily Digest/Highlights + Senate",
  date: Date.parse("1994-01-25"),
  section: "Daily Digest"
}

pages_table.insert(page_attributes)

browser = GoVerbal::GPOSiteBrowser.new

DB[:pages].where("content is null").each do |page|
  id = page[:id]
  url = page[:url]

  page = browser.go_to(url)
  content = page.body

  DB[:pages].where(:id => id).update(content: content)
end
