class ApplicationController < ActionController::API
  respond_to :json

  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def is_admin?
    return @current_user.role == 'admin'
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :phone, :cpf ])
  end

  def authenticate_user
    public_key = OpenSSL::PKey::RSA.new ENV["JWT_USER_PUBLIC_KEY"]
    puts "%"*50
    puts public_key
    puts "%"*50
    if request.headers['Authorization'].present?
      decoded_token = JWT.decode request.headers['Authorization'], public_key, true, { algorithm: 'RS256' }
      puts "#"*50
      puts decoded_token
      puts "#"*50
      if decoded_token.first['exp'] >= DateTime.now.to_i
        if decoded_token.first['id'].to_s == params[:id]
          @current_user_id = decoded_token.first['id']
        else
          @current_user_id = nil
          render json: { error: 'Unauthorized!' }, status: :unauthorized
        end
      else
        render json: { error: 'Token expired!' }, status: :unauthorized
      end
    end
  end
  
  def authenticate_user!(options = {})
    head :unauthorized unless signed_in?
  end

  def current_user
    @current_user ||= super || User.find(@current_user_id)
  end

  def signed_in?
    @current_user_id.present?
  end
end
