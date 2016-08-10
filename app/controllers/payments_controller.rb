class PaymentsController < ApplicationController
	
	def create
		@reservation = Reservation.find(params[:reservation_id])
		nonce_from_the_client = params[:payment_method_nonce]
		result = Braintree::Transaction.sale(
		  :amount => @reservation.listing.price,
		  :payment_method_nonce => nonce_from_the_client,
		  :options => {
		  :submit_for_settlement => true
		  }
		)

		if result.success?
			@reservation.update(transaction_id: result.transaction.id)
			@customer = current_user
			@listing = @reservation.listing
			ReservationMailer.reservation_email(@customer, @listing).deliver_later
			redirect_to @reservation.listing
		else
			@listing_id = @reservation.listing.id
			@reservation.destroy
			redirect_to Listing.find(@listing_id)
		end

	end

	def new
		@reservation = Reservation.find(params[:reservation_id])
		@client_token = Braintree::ClientToken.generate
	end

end