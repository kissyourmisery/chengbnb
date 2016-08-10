class ListingsController < ApplicationController

	def index
		@filterrific = initialize_filterrific(
      Listing,
      params[:filterrific],
      select_options: {
        with_tag_id: Tag.options_for_select
      }
    ) or return

    @listings = @filterrific.find
    
    respond_to do |format|
      format.html
      format.js
    end
	end
	
	def create
		@listing = current_user.listings.new(listing_params)
		if @listing.save
			create_available_dates_for_listing
			redirect_to listings_path
		end
	end

	def new
		if signed_in?
			@listing = Listing.new
		else
			redirect_to sign_in_path
		end
	end

	def edit
		@listing = Listing.find(params[:id])
	end

	def show
		@listing = Listing.find(params[:id])
	end

	def update
		@listing = Listing.find(params[:id])
		@listing.update(listing_params) ####CAN'T UPDATE AVAILABLE DATE!!
		edit_available_dates_for_listing
		redirect_to listing_path(@listing)
		#or redirect_to @listing
	end

	def destroy
		@listing = Listing.find(params[:id])
		@listing.destroy
		redirect_to listings_path
	end

	private
	def listing_params
		params.require(:listing).permit(:title, :location, :number_of_beds, :number_of_guests, :price, tag_ids: [], photos: [])
	end

	def listing_dates
		params.require(:listing).permit(:start_date, :end_date)
	end

	def create_available_dates_for_listing
		#faulty!!
		# start_date = Date.strptime(listing_dates[:start_date], '%m/%d/%Y')
		# end_date = Date.strptime(listing_dates[:end_date], '%m/%d/%Y')
		# date_range = (start_date..end_date).to_a
		# date_range.each do |date|
		# 	@listing.available_dates.create(date: date, availability: true)
		# end
		(Date.strptime(listing_dates[:start_date], '%m/%d/%Y')..Date.strptime(listing_dates[:end_date], '%m/%d/%Y')).to_a.each do |date|
			@listing.available_dates.create(date: date, availability: true)
		end
	end

	def edit_available_dates_for_listing 
		@listing.available_dates.destroy_all
		create_available_dates_for_listing
	end

end



