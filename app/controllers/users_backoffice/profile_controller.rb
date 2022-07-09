class UsersBackoffice::ProfileController < UsersBackofficeController
    before_action :verify_password, only: [:update]
    before_action :set_user
    
    def edit
        @user.build_user_profile if @user.user_profile.blank?
    end

    def update
        if @user.update(user_params)
            
            bypass_sign_in(@user)
            redirect_to users_backoffice_profile_path, notice: "Atualizado com sucesso!"
          else
            render :edit
          end
    end

    private

    def set_user
        @user = User.find(current_user.id)
    end

    def user_params
        params_user = params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, user_profile_attributes: [:id, :address, :gender, :birthdate, :avatar])
    end

    def verify_password
        if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
            params[:user].extract!(:password, :password_confirmation)
        end
    end
end
