class TagsController < ApplicationController

	# def index
	# end

	# def show
		
	# end


	private
	def tag_params
		params.require(:tag).permit(:content)
	end

end