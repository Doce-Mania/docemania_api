class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :email, uniqueness: { case_sensitive: false }, presence: true, allow_blank: false
  has_many :address

  enum role: %i[user admin].freeze
  
 # jwt is type of token, user attentication 
  def generate_jwt
    JWT.encode({ id: id,
                exp: 5.minutes.from_now.to_i },
               nil)
  end
end
