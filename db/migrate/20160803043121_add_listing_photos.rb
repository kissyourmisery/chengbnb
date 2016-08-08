class AddListingPhotos < ActiveRecord::Migration

	def change
		add_column :listings, :photos, :text, array:true, default: []
	end
end