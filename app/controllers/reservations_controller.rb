class ReservationsController < ApplicationController

	def index

	end
	
	def create
		input = reservation_params
		convert_dates(input)
		@reservation = Reservation.new(input)
		@reservation.user_id = current_user.id 
		if @reservation.save 
			reserve_availability(input[:start_date], input[:end_date], input[:listing_id])

			@customer = current_user
			@listing = @reservation.listing
			ReservationMailer.reservation_email(@customer, @listing).deliver_later
			redirect_to Listing.find(input[:listing_id])
		end
	end


	def new
		if signed_in?
			@reservation = Reservation.new
		else
			redirect_to sign_in_path
		end

	end

	def edit #how to edit reservation???

	end

	def show

	end

	def update

	end

	def destroy 
		@reservation = Reservation.find(params[:id])
		@user_id = @reservation.user.id
		(@reservation.start_date .. @reservation.end_date).to_a.each do |date|
	     AvailableDate.find_by(listing_id: @reservation.listing.id, date: date).update(availability: true)
	  end

	  @reservation.destroy

	  redirect_to "/users/" + @user_id.to_s

	end

	private
	def reservation_params
		params.require(:reservation).permit(:start_date, :end_date, :num_guests, :listing_id)
	end

	def convert_dates(input)
		input[:start_date] = Date.strptime(input[:start_date], '%m/%d/%Y')
		input[:end_date] = Date.strptime(input[:end_date], '%m/%d/%Y')
	end

	
  def reserve_availability(start_date, end_date, listing_id)
	  (start_date .. end_date).to_a.each do |date|
	     AvailableDate.find_by(listing_id: listing_id, date: date).update(availability: false)
	  end
	end

end