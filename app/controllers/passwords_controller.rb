class PasswordsController < Devise::PasswordsController
  respond_to :json

    def create
        self.user = User.send_reset_password_instructions(params[:user])

        if successfully_sent?(user)
            render json: { message: "Reset password instructions sent" }
        else
            render json: { message: "Error sending reset password instructions" }, status: :unprocessable_entity
        end
    end

    def update
        self.user = User.reset_password_by_token(params[:user])

        if user.errors.empty?
            sign_in(user)
            render json: { message: "Password successfully reset", token: current_token }, status: :ok
        else
            render json: { error: user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    private

    def current_token
        request.env['warden-jwt_auth.token']
    end
end