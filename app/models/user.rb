class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :is_waiting, :password, :password_confirmation, :username
  belongs_to :list
end
