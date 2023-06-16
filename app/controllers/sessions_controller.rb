class SessionsController < Devise::SessionsController
  respond_to :json

  def create
    self.resource = warden.authenticate!(auth_options)
    if resource
      sign_in(resource_name, resource)
      render json: { message: 'Signed in successfully', user: }
    else
      render json: { message: 'Invalid email or password' }, status: :unprocessable_entity
    end
  end
end
