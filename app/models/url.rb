class Url < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
	validates :original_url, uniqueness: true
	validates :valid_url?, numericality: { message: "Unable to shorten that link. It is not a valid url."}

	before_create do
		self.shorten
		self.title = Mechanize.new.get(self.original_url).title
	end


	@@alphanumeric = []
	@@alphanumeric << ("1".."9").to_a
	@@alphanumeric << ("A".."Z").to_a
	@@alphanumeric << ("a".."z").to_a

	def shorten	
		shorturl = @@alphanumeric.flatten.sample(6).join
		until Url.where(short_url: shorturl) == []
			shorturl = @@alphanumeric.flatten.sample(6).join
		end
		self.short_url = shorturl
	end

	def valid_url?
		# original_url =~ /^https?:\/\/.+\.\w{3}/
		original_url =~ URI::regexp
	end
end
