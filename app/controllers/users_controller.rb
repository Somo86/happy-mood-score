class UsersController < PublicController
  def activate
    if @user = User.load_from_activation_token(params[:id])
      @user.activate!
      @user.generate_reset_password_token!

      redirect_to(password_reset_path(@user.reset_password_token), notice: I18n.t('server.accountActivatedEmail.subject'))
    else
      not_authenticated
    end
  end
end
