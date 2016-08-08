class CreateListingTags < ActiveRecord::Migration
  def change
    create_table :listing_tags do |t|
    	t.belongs_to :listing
    	t.belongs_to :tag
    	t.timestamps
    end
  end
end
