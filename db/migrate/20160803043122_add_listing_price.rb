class AddListingPrice < ActiveRecord::Migration

	def change
		add_column :listings, :price, :integer
	end
end