class AddReservationTransaction < ActiveRecord::Migration

	def change
		add_column :reservations, :transaction_id, :text
	end
end