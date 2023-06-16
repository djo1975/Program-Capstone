class RegistrationsController < Devise::RegistrationsController
    respond_to :json

    def create
        build_user(sign_up_params)

        if user.save
            sign_up(user)
            render json: { message: 'Signed up successfully', user: user }
        else
            render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    private

    def sign_up_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end