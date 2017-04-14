class InitializeCount < ActiveRecord::Migration
	def change
		url_list=Url.all
		url_list.each do |url|
			url.update(click_count: 0)
		end
	end
end
