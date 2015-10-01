class Users::SessionsController < Devise::SessionsController
# before_filter :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
		auth_params = params.require(:user).permit(:email, :password)
		user = User.find_by(email: auth_params[:email])

		__invalid_email_or_password unless user

		if user.valid_password?(params[:password])
			sign_in(user)
			redirect_to dashboard_user_path and return
		else
			__invalid_email_or_password
		end
  end

	def __invalid_email_or_password
		redirect_to root_path, alert: "Invalid email or password"
	end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end
end
