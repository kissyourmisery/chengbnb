class AvailableDate < ActiveRecord::Base
	belongs_to :listing
	validates :listing_id, uniqueness: { scope: :date}
end