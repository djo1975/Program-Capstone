class ApplicationController < ActionController::Base
  def placeholder
    render json: { message: 'root page accessed' }, status: :ok
  end
end
