class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role
  # attr_accessible :title, :body

  ADMIN_ROLES = ['admin']

  ROLES = ['user','admin']
  
  belongs_to :presenter

  has_many :authentications

  has_many :lists
  
  def apply_omniauth omniauth
    self.email = omniauth['info']['email'] if self.email.blank?
    authentications.build(:provider => omniauth['provider'],
                          :uid => omniauth['uid'])
  end

  def is_admin?
    ADMIN_ROLES.include?(self.role)
  end  
end
