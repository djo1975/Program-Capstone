class SessionsController < Devise::SessionsController
    respond_to :json

    def create
        self.user = warden.authenticate!(auth_options)
        sign_in(user)

        render json: { message: 'Signed in successfully', user: user }
    end
end