class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :title
      t.string :location
      t.integer :number_of_beds
      t.integer :number_of_guests
      t.belongs_to :user, index: true
    end
  end
end