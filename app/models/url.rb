class Url < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
	validates :original_url, uniqueness: true
	validates :valid_url?, numericality: { message: "Unable to shorten that link. It is not a valid url."}

	before_create do
		self.shorten
		begin
		  # here is the code that could raise ArgumentError 
		  self.title = Mechanize.new.get(self.original_url).title	  
		rescue Mechanize::ResponseCodeError
		  self.title = "No Title"
		end
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
		original_url =~ URI::regexp
	end
end
