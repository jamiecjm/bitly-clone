class AddTitle < ActiveRecord::Migration
	def change
		add_column :urls,:title,:string
	end
end
