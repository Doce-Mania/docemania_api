class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  #attr_accessor :name, :phone, :cpf 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :email, uniqueness: { case_sensitive: false }, presence: true, allow_blank: false
  has_many :address

  enum role: %i[user admin].freeze
  
 # jwt is type of token, user attentication 
  def generate_jwt
    private_key = OpenSSL::PKey::RSA.new ENV["JWT_USER_PRIVATE_KEY"]

    JWT.encode(
      {
        id: id,
        exp: 5.hours.from_now.to_i
      },
      private_key,
      'RS256'
    )
  end
end
