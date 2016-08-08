class UsersController < Clearance::UsersController

	def show
		@user = User.find(params[:id])
	end

	def edit # very important!! must not forget!! go back to sinatra to revise!
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		@user.update(user_params)
		redirect_to @user
	end

	private
	def user_params
		params.require(:user).permit(:email, :password, :profile_photo)
	end
end
