# lines = File.foreach('db/urls').first(10)

File.open("db/urls").each_line do |row|
	row.delete!("(")
	row.delete!(")")
	row.delete!(",")
	row.delete!(";")
	row.delete!("\n")
	Url.create(original_url: row)
end

# urls = File.read("db/urls") 
# 	urls.gsub!(/\n/, "")
# 	urls.gsub!(/\(/, "")
# 	urls.gsub!(/\)/, "")
# 	urls.gsub!(/\,/, "")
# 	urls.gsub!(/\;/, "")
	
# Url.transaction do
# 	columns = [:original_url]
# 	Url.import columns, urls, validate: false
# end
