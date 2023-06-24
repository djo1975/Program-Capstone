class RegistrationsController < Devise::RegistrationsController
  include Apipie::DSL

  respond_to :json

  # POST /users/sign_up
  # Sign up a new user
  #
  # @api {post} /users/sign_up
  # @param [Hash] user User parameters
  # @option user [String] :username Username
  # @option user [String] :email Email
  # @option user [String] :password Password
  # @option user [String] :password_confirmation Password confirmation
  #
  # @return [JSON] JSON response with status and message
  api!({
         method: 'POST',
         path: '/users/sign_up',
         summary: 'Sign up a new user',
         parameters: [
           {
             name: 'user',
             description: 'User parameters',
             required: true,
             type: 'Hash',
             properties: {
               username: { type: 'String', desc: 'Username' },
               email: { type: 'String', desc: 'Email' },
               password: { type: 'String', desc: 'Password' },
               password_confirmation: { type: 'String', desc: 'Password confirmation' }
             }
           }
         ],
         response: { body: { status: 'JSON', desc: 'JSON response with status and message' } }
       })
  def create
    @user = User.new(sign_up_params)

    if @user.valid?
      @user.jti = @user.generate_jwt
      @user.save
      render json: { message: 'Signed up successfully', user: @user }
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
