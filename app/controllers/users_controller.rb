class UsersController < ApplicationController

	def show
		@user = User.find(params[:id])
		#debugger
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)    # Not the final implementation!
		if @user.save
			log_in @user
			flash[:success] = "Welcome to the Sample App!"
			redirect_to @user
		else
			render 'new'
		end
	end

	def user_params
		params.require(:user).permit(:name, :email, :password,
									 :password_confirmation)
	end

	# Returns true if the given token matches the digest.
	def authenticated?(remember_token)
		BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end

end
