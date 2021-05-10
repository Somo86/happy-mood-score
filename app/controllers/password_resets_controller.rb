class PasswordResetsController < PublicController
  def create
    @user = User.find_by_email(params[:email])

    @user.deliver_reset_password_instructions! if @user
    @form_sent = true
    @invalid_email = params[:email].blank?

    render 'new'
  end

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    if @user.blank?
      not_authenticated
      return
    end
  end

  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    if @user.blank?
      not_authenticated
      return
    end

    @user.password_confirmation = params[:user][:password_confirmation]

    if both_passwords_present && @user.change_password(params[:user][:password])
      redirect_to(login_path, notice: 'Password was successfully updated.')
    else
      @no_match = params[:user][:password] != params[:user][:password_confirmation]
      @invalid_credentials = true

      render 'edit'
    end
  end

  private

  def both_passwords_present
    params[:user][:password].present? && params[:user][:password_confirmation].present?
  end
end
