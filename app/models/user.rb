class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable
  attr_writer :login
  validate :validate_username
  
  has_many :posts
  has_many :comments

  #login by username or email
  def login
      @login || self.username || self.email
  end

  #overriding loging parameters
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  #username validation != other one email
  def validate_username
    if User.where(email: username).exists? || User.where(username: username).exists? 
      errors.add(:username, :invalid)
    end
  end



  #check post access
  def post_access?(post)
    if post.user_id == self.id || self.admin?
      return true 
    else
      return false
    end
  end 

  #check comment access
  def comment_access?(comment)
    if comment.user_id == self.id || self.admin? || comment.post.user_id== self.id
      return true 
    else 
      return false 
    end 
  end 

end
