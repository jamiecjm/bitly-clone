class Url < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
	validates :original_url, uniqueness: true

	after_create do
		shorturl = self.shorten
		until Url.where(short_url: shorturl)==[]
			shorturl = self.shorten
		end
		self.update(short_url: shorturl)
	end

	def shorten
		alphanumeric = []
		alphanumeric << ("1".."9").to_a
		alphanumeric << ("A".."Z").to_a
		alphanumeric << ("a".."z").to_a
		short_url_string = alphanumeric.flatten.sample(6).join
	end
end
